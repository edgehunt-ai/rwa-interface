import React, { useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import {
  PrivyProvider,
  useExportWallet,
  useLinkWithPasskey,
  useLogin,
  usePrivy,
  useUnlinkPasskey,
} from '@privy-io/react-auth';

const state = {
  appId: null,
  clientId: null,
  initialize: null,
  login: null,
  ready: false,
  authenticated: false,
  user: null,
  getAccessToken: null,
  logout: null,
};

let root;
let pendingLogin;
let pendingPasskeyLink;

function userId(user) {
  return typeof user?.id === 'string' ? user.id : null;
}

function settleLogin(user) {
  if (!pendingLogin) return;
  const resolve = pendingLogin.resolve;
  pendingLogin = null;
  resolve(userId(user));
}

function passkeyFromUser(user) {
  const account = user?.linkedAccounts?.find((item) => item.type === 'passkey');
  if (!account || typeof account.credentialId !== 'string') return null;
  return {
    credentialId: account.credentialId,
    authenticatorName:
      typeof account.authenticatorName === 'string' ? account.authenticatorName : null,
  };
}

function settlePasskeyLink(user) {
  if (!pendingPasskeyLink) return;
  const passkey = passkeyFromUser(user);
  if (!passkey) return;
  const resolve = pendingPasskeyLink.resolve;
  pendingPasskeyLink = null;
  resolve(passkey);
}

function PrivyBridge() {
  const { authenticated, getAccessToken, logout, ready, user } = usePrivy();
  const { login } = useLogin({ onComplete: settleLogin });
  const { linkWithPasskey } = useLinkWithPasskey();
  const { unlink } = useUnlinkPasskey();

  useEffect(() => {
    state.ready = ready;
    state.authenticated = authenticated;
    state.user = user;
    state.getAccessToken = getAccessToken;
    state.logout = logout;
    state.login = login;
    state.linkPasskey = linkWithPasskey;
    state.unlinkPasskey = unlink;

    if (ready && state.initialize) {
      state.initialize.resolve(authenticated ? userId(user) : null);
      state.initialize = null;
    }
    if (authenticated) {
      settleLogin(user);
      settlePasskeyLink(user);
    }
  }, [
    authenticated,
    getAccessToken,
    linkWithPasskey,
    login,
    logout,
    ready,
    unlink,
    user,
  ]);

  return null;
}

function mount() {
  if (root) return;
  const host = document.createElement('div');
  host.id = 'rwa-privy-auth-root';
  host.hidden = true;
  document.body.append(host);
  root = createRoot(host);
  root.render(
    // Browser authentication is configured by the Privy App ID. Passing the
    // mobile native client ID causes Privy to reject OAuth initialization with
    // `invalid_native_app_id`.
    <PrivyProvider appId={state.appId}>
      <PrivyBridge />
    </PrivyProvider>,
  );
}

function postExportMessage(type, detail) {
  const message = JSON.stringify({ type, ...(detail || {}) });
  if (window.RwaPrivateKeyExport?.postMessage) {
    window.RwaPrivateKeyExport.postMessage(message);
  }
  if (window.webkit?.messageHandlers?.RwaPrivateKeyExport?.postMessage) {
    window.webkit.messageHandlers.RwaPrivateKeyExport.postMessage(message);
  }
}

function isNativeExportWebView() {
  return Boolean(
    window.RwaPrivateKeyExport?.postMessage ||
      window.webkit?.messageHandlers?.RwaPrivateKeyExport?.postMessage,
  );
}

function PrivateKeyExport() {
  const { authenticated, ready } = usePrivy();
  const [error, setError] = React.useState(null);
  const reportError = React.useCallback((value) => {
    const message = value?.message || value?.privyErrorCode || String(value);
    console.error('[Privy export]', value);
    setError(message);
    postExportMessage('error', { message });
  }, []);
  const { login } = useLogin({
    onComplete: () => undefined,
    onError: reportError,
  });
  const { exportWallet } = useExportWallet();
  const loginStarted = React.useRef(false);
  const exportStarted = React.useRef(false);

  React.useEffect(() => {
    if (!ready || authenticated || loginStarted.current) return;
    loginStarted.current = true;
    // Google blocks OAuth in many embedded WebViews. Keep social login in a
    // normal browser, but use email OTP inside the native export WebView.
    login({
      loginMethods: isNativeExportWebView() ? ['email'] : ['google', 'email'],
    }).catch(reportError);
  }, [authenticated, login, ready, reportError]);

  React.useEffect(() => {
    if (!ready || !authenticated || exportStarted.current) return;
    exportStarted.current = true;
    (async () => {
      try {
        // Wait for the authenticated Privy state to settle before exporting;
        // exportWallet requires the access token created by that state update.
        await new Promise((resolve) => setTimeout(resolve, 0));
        await exportWallet();
        // Privy's export promise resolves when its secure modal exits. The
        // private key never crosses this bridge; close the host WebView too.
        postExportMessage('close');
      } catch (error) {
        reportError(error);
      }
    })();
  }, [authenticated, exportWallet, ready, reportError]);

  return (
    <main className="export-state">
      <div className="spinner" />
      <h1>Export private key</h1>
      <p>{error || (authenticated ? 'Preparing secure export…' : 'Continue with Privy to verify your identity.')}</p>
    </main>
  );
}

function mountPrivateKeyExport() {
  const appId =
    typeof __PRIVY_EXPORT_APP_ID__ === 'string'
      ? __PRIVY_EXPORT_APP_ID__
      : new URLSearchParams(window.location.search).get('appId');
  if (!appId) {
    postExportMessage('error', { message: 'Missing Privy app ID.' });
    return;
  }
  const host = document.getElementById('rwa-private-key-export-root');
  if (!host) return;
  createRoot(host).render(
    <PrivyProvider appId={appId}>
      <PrivateKeyExport />
    </PrivyProvider>,
  );
}

window.rwaPrivyAuth = {
  initialize(appId, clientId) {
    if (!appId || !clientId) {
      return Promise.reject(new Error('Privy app ID and client ID are required.'));
    }
    if (root && (state.appId !== appId || state.clientId !== clientId)) {
      return Promise.reject(new Error('Privy is already configured.'));
    }
    state.appId = appId;
    state.clientId = clientId;
    return new Promise((resolve, reject) => {
      state.initialize = { resolve, reject };
      mount();
    });
  },

  login() {
    if (!state.ready || !state.login) {
      return Promise.reject(new Error('Privy is not ready.'));
    }
    if (state.authenticated) return Promise.resolve(userId(state.user));
    return new Promise((resolve, reject) => {
      pendingLogin = { resolve, reject };
      try {
        state.login();
      } catch (error) {
        pendingLogin = null;
        reject(error);
      }
    });
  },

  getPasskey() {
    if (!state.authenticated) return Promise.resolve(null);
    return Promise.resolve(passkeyFromUser(state.user));
  },

  linkPasskey(name) {
    if (!state.authenticated || !state.linkPasskey) {
      return Promise.reject(new Error('Privy is not ready.'));
    }
    if (pendingPasskeyLink) {
      return Promise.reject(new Error('A passkey setup is already in progress.'));
    }
    return new Promise((resolve, reject) => {
      pendingPasskeyLink = { resolve, reject };
      state.linkPasskey(name ? { name } : undefined).catch((error) => {
        pendingPasskeyLink = null;
        reject(error);
      });
    });
  },

  async unlinkPasskey(credentialId) {
    if (!state.authenticated || !state.unlinkPasskey) {
      throw new Error('Privy is not ready.');
    }
    const user = await state.unlinkPasskey({ credentialId });
    state.user = user;
  },

  async getAccessToken() {
    if (!state.authenticated || !state.getAccessToken) return null;
    return state.getAccessToken();
  },

  async logout() {
    if (state.logout) await state.logout();
    state.authenticated = false;
    state.user = null;
  },
};

if (document.getElementById('rwa-private-key-export-root')) {
  mountPrivateKeyExport();
}
