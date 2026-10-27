// Legal copy and typography from the supplied Figma documents.
// Updated from the 10.20 Privacy Policy & Terms of Use Figma section.
// Privacy copy synced with the 27 October 2026 NoBell Privacy Policy in Notion.
// Keep page titles in the existing localized screen header.
import 'package:flutter/material.dart';

class LegalParagraph {
  const LegalParagraph(
    this.spans, {
    this.size = 13,
    this.top = 0,
    this.bottom = 0,
    this.bullet = false,
  });
  final List<TextSpan> spans;
  final double size;
  final double top;
  final double bottom;
  final bool bullet;
}

const termsParagraphs = <LegalParagraph>[
  LegalParagraph(
    [
      TextSpan(
        text: "Terms of Use",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 20,
    bottom: 8,
  ),
  LegalParagraph(
    [TextSpan(text: "Last Updated: 27 October 2026")],
    size: 12,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "These Terms of Use (“Terms”) govern your access to and use of the NoBell mobile application, website, software, interfaces, tools, content, and related services (collectively, the “Interface”). The Interface is made available by or on behalf of ",
    ),
    TextSpan(
      text: "TECHNOVA LABS PTE. LTD",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: "., a company incorporated in Singapore that operates the NoBell brand (“Company”, “NoBell”, “we”, “us”, or “our”).",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "Please read these Terms carefully before accessing or using the Interface. By downloading, accessing, connecting a wallet to, or otherwise using the Interface, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, you must not access or use the Interface.",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "For purposes of these Terms, “you” and “your” mean the individual or entity accessing or using the Interface. If you use the Interface on behalf of a company or other legal entity, you represent and warrant that you are duly authorised to bind that entity to these Terms, and all references to “you” shall include that entity.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "1. DEFINITIONS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "For purposes of these Terms:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Assets”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means digital assets, tokens, tokenized securities, virtual assets, or other blockchain-based assets that may be displayed or made available for trading through the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Blockchain Networks”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means public or permissioned blockchain networks supported by the Interface from time to time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Liquidity Source”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means any third-party decentralized exchange, liquidity provider, market maker, protocol, trading venue, automated market maker, order book, aggregator, or other source of liquidity or trading quotes accessible through the Interface, including any liquidity provided by NoBell or its affiliates.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Perpetual Contracts”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means perpetual futures or perpetual derivative contracts made available through third-party protocols or trading venues accessible through the Interface, including certain builder-deployed perpetual markets on Hyperliquid.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Protocols”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means blockchain protocols, decentralized applications, smart contracts, trading venues, liquidity protocols, and other on-chain systems that may be accessed through or integrated with the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Tokenized Securities”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means blockchain-based tokens or other digital representations that provide economic exposure to, track, reference, or otherwise relate to securities or other traditional financial assets, including supported bStocks products.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "“Third-Party Services”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " means any third-party wallet, protocol, liquidity source, blockchain infrastructure, oracle, market-data provider, bridge, API, RPC provider, custody provider, issuer, or other third-party service integrated with or accessible through the Interface.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "2. ELIGIBILITY AND ACCEPTANCE",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "You may use the Interface only if:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "1. you are at least the age of majority in your jurisdiction of residence;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. you have the legal capacity and authority to enter into these Terms;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "3. your use of the Interface is permitted under all laws and regulations applicable to you; and",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "4. you are not a Prohibited Person.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "If you use the Interface on behalf of an entity, you represent and warrant that you have full authority to bind that entity to these Terms.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "2.1 Prohibited Persons and Jurisdictions",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "A “Prohibited Person” means any individual or entity that:",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "1. appears on, or is owned or controlled by a person appearing on, any applicable sanctions or restricted-party list maintained by the United Nations, United States, European Union, United Kingdom, or other applicable governmental authority;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. is located, organised, incorporated, or resident in a jurisdiction subject to comprehensive economic or trade sanctions or other restrictions applicable to the Company;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "3. is otherwise prohibited from accessing or using the Interface under applicable law; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "4. accesses or uses the Interface on behalf of, or for the benefit of, any person described above.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may implement technical and procedural measures, including IP-based geolocation, device-level restrictions, wallet screening, or other compliance tools, to detect and restrict access by Prohibited Persons.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You represent and warrant that you are not a Prohibited Person and that you will not use the Interface to conduct or facilitate transactions involving Prohibited Persons or prohibited jurisdictions.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "2.2 No Circumvention",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "You must not use VPNs, proxies, Tor, or other technical means to circumvent geographic restrictions, sanctions controls, eligibility requirements, or other access controls implemented by the Company or relevant Third-Party Services.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "2.3 Compliance Checks",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Company may request information or documents, screen wallet addresses and transactions, and apply other compliance controls where reasonably necessary to comply with law, manage risk, or protect the Interface. You agree to provide accurate and complete information in response to any lawful request. The Company may refuse, restrict, or discontinue access if required information is not provided or if the Company reasonably identifies legal, sanctions, fraud, security, or other material risk.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "3. DESCRIPTION OF NoBell",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Company provides NoBell as a non-custodial mobile trading interface that enables users to access and interact with supported blockchain-based trading markets and protocols.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The Interface may provide access to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "1. spot trading of digital assets and Tokenized Securities;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. Perpetual Contracts made available through third-party protocols;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "3. liquidity and trading quotes from multiple Liquidity Sources;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "4. market data, asset information, prices, charts, transaction estimates, and other trading-related information; and",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "5. other trading-related functionality introduced by the Company from time to time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell is not itself the underlying blockchain network or Protocol through which a transaction is ultimately recorded or settled.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Unless expressly stated otherwise, the Company is not a bank, broker, dealer, securities exchange, clearing agency, custodian, investment adviser, portfolio manager, or fiduciary. The Interface does not constitute an offer, solicitation, or recommendation by the Company to enter into any transaction where such activity would be unlawful.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Except where expressly stated otherwise in these Terms, NoBell does not take custody of your assets or private keys.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You remain solely responsible for your wallet, private keys, recovery phrases, transaction approvals, and all transactions initiated through your wallet.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "4. NON-CUSTODIAL WALLET",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "NoBell operates on a non-custodial basis.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company does not hold, control, or have access to your private keys or recovery phrases and cannot restore access to your wallet if you lose your private keys, recovery phrase, or other authentication credentials.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for maintaining the security of your wallet and all associated credentials.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Any transaction that requires your signature must be reviewed and authorised by you before submission.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Once a blockchain transaction has been signed and submitted, it may be irreversible and may not be capable of being cancelled, reversed, or recovered by NoBell.",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "You acknowledge that NoBell does not guarantee the successful execution, confirmation, settlement, or reversibility of any transaction.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are responsible for maintaining records of your transactions and complying with any tax, reporting, accounting, or regulatory obligations applicable to you.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Third-party wallet providers may impose separate terms and may collect or process information independently. The Company is not responsible for the operation or security of any third-party wallet.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "5. LIQUIDITY AGGREGATION AND ROUTING",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "NoBell may aggregate trading liquidity and quotes from multiple Liquidity Sources.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Interface may compare available quotes, prices, liquidity, fees, estimated slippage, price impact, and other execution parameters and may route a transaction to a Liquidity Source based on the routing methodology implemented by NoBell.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The routing methodology may take into account factors including:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. quoted price;")]),
  LegalParagraph([TextSpan(text: "2. available liquidity;")]),
  LegalParagraph([TextSpan(text: "3. estimated price impact;")]),
  LegalParagraph([TextSpan(text: "4. fees;")]),
  LegalParagraph([TextSpan(text: "5. expected execution quality;")]),
  LegalParagraph([TextSpan(text: "6. network and protocol conditions;")]),
  LegalParagraph([TextSpan(text: "7. transaction size;")]),
  LegalParagraph([TextSpan(text: "8. asset and market availability; and")]),
  LegalParagraph([
    TextSpan(text: "9. other technical or commercial considerations."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Liquidity Source selected by NoBell may change between the time a quote is displayed and the time a transaction is executed.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not guarantee that the selected Liquidity Source will provide the best price or best execution available across every market, venue, protocol, or liquidity source.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Prices and quotes displayed through the Interface may differ from prices available elsewhere.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You acknowledge that market conditions may change rapidly and that a transaction may execute at a price materially different from the price displayed before confirmation.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "5.1 NoBell and Affiliate Liquidity",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "NoBell, its affiliates, or entities associated with NoBell may, from time to time, provide liquidity, submit quotes, participate as a liquidity provider, or otherwise make liquidity available for transactions initiated through the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Accordingly, NoBell or its affiliates may have an economic interest in the execution of certain transactions.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Such economic interests may include trading fees, spreads, rebates, liquidity incentives, or other compensation.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Where NoBell or an affiliate provides liquidity, the transaction may be routed to such liquidity in accordance with the applicable routing methodology.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The existence of NoBell or affiliate liquidity does not mean that NoBell guarantees execution at the best price available across all third-party markets or venues.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "6. TRADING EXECUTION",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface may display estimated prices, quotes, minimum received amounts, maximum sold amounts, price impact, slippage, fees, funding rates, and other transaction information.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Such information is provided for informational and execution purposes only and may change before a transaction is confirmed.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for reviewing the transaction details before signing or approving a transaction.",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "A displayed quote does not constitute a binding offer or guarantee of execution.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "Transactions may:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "fail;")], bullet: true),
  LegalParagraph([TextSpan(text: "revert;")], bullet: true),
  LegalParagraph([TextSpan(text: "be delayed;")], bullet: true),
  LegalParagraph([TextSpan(text: "be partially executed;")], bullet: true),
  LegalParagraph([
    TextSpan(text: "execute at a different price;"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "incur greater slippage than estimated; or"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "become unavailable before execution."),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not guarantee successful execution or any specific execution price.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7. TOKENIZED SECURITIES AND BSTOCKS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface may provide access to Tokenized Securities, including supported bStocks products.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Tokenized Securities may provide economic exposure to, track, reference, or otherwise represent an interest in an underlying security or financial asset.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7.1 No Direct Ownership of Underlying Securities",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Unless expressly provided by the applicable issuer documentation, purchasing or holding a Tokenized Security through the Interface does not necessarily constitute direct ownership of the underlying security.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Holding a token representing or tracking an underlying stock does not necessarily provide the holder with shareholder rights, voting rights, dividend rights, or any other rights that a direct holder of the underlying security may have.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You must review the applicable issuer documentation and terms for each Tokenized Security before trading.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7.2 NoBell Is Not the Issuer",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Unless expressly stated otherwise, NoBell is not the issuer, sponsor, custodian, administrator, broker, transfer agent, or legal owner of the underlying securities associated with any Tokenized Security.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "NoBell does not guarantee:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "1. the existence or value of the underlying security;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. the solvency or performance of the issuer or any relevant intermediary;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "3. the maintenance of any particular backing arrangement;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "4. the ability to redeem a Tokenized Security;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "5. the continued availability of a Tokenized Security; or"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "6. that the Tokenized Security will trade at or near the value of the underlying security.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7.3 Price Tracking Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "The price of a Tokenized Security may differ materially from the price of its referenced or underlying security.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "Differences may arise from:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "market hours;")], bullet: true),
  LegalParagraph([TextSpan(text: "liquidity conditions;")], bullet: true),
  LegalParagraph([TextSpan(text: "trading venue differences;")], bullet: true),
  LegalParagraph([TextSpan(text: "blockchain activity;")], bullet: true),
  LegalParagraph([TextSpan(text: "supply and demand;")], bullet: true),
  LegalParagraph([TextSpan(text: "currency conversion;")], bullet: true),
  LegalParagraph([TextSpan(text: "fees;")], bullet: true),
  LegalParagraph([
    TextSpan(text: "oracle or pricing mechanisms;"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "issuer arrangements;")], bullet: true),
  LegalParagraph([TextSpan(text: "market fragmentation; or")], bullet: true),
  LegalParagraph([TextSpan(text: "other factors.")], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not guarantee that the price of any Tokenized Security will track the underlying security accurately or continuously.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7.4 Corporate Actions",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Corporate actions affecting an underlying security, including dividends, stock splits, reverse splits, mergers, acquisitions, reorganisations, or other events, may affect a Tokenized Security.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The treatment of such events may be determined by the applicable issuer, protocol, or other relevant third party.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not guarantee any particular treatment of corporate actions.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7.5 Regulatory Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Tokenized Securities may be subject to securities, financial services, investment, derivatives, payments, or other regulation depending on the applicable jurisdiction and structure.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "The regulatory status of Tokenized Securities may change over time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for determining whether you are permitted to access or trade any Tokenized Security in your jurisdiction.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8. PERPETUAL CONTRACTS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface may provide access to Perpetual Contracts through third-party protocols, including builder-deployed perpetual markets on Hyperliquid.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Perpetual Contracts are derivative instruments and may involve leverage, margin requirements, funding payments, liquidation mechanisms, and other risks.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8.1 Third-Party Perpetual Markets",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Perpetual Contracts accessible through the Interface may be operated by independent third-party protocols or market deployers.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The relevant protocol or market deployer may determine or control certain market parameters, including, where applicable:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "contract specifications;")], bullet: true),
  LegalParagraph([TextSpan(text: "oracle mechanisms;")], bullet: true),
  LegalParagraph([TextSpan(text: "leverage limits;")], bullet: true),
  LegalParagraph([TextSpan(text: "margin requirements;")], bullet: true),
  LegalParagraph([TextSpan(text: "funding parameters;")], bullet: true),
  LegalParagraph([TextSpan(text: "open interest caps;")], bullet: true),
  LegalParagraph([TextSpan(text: "fees;")], bullet: true),
  LegalParagraph([TextSpan(text: "market status; and")], bullet: true),
  LegalParagraph([
    TextSpan(text: "trading or settlement mechanisms."),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not control the underlying protocol or the market deployer.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "For HIP-3 markets, the relevant deployer is responsible for market definition and operation, including oracle definitions and certain market parameters.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8.2 Leverage and Liquidation",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([TextSpan(text: "Perpetual Contracts may involve leverage.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Leverage can magnify both gains and losses."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "A relatively small movement in the price of the underlying asset may result in substantial losses and may cause the liquidation of your position.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You may lose all or substantially all of the assets or collateral committed to a leveraged position.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You may also be liable for fees, funding payments, or other costs associated with maintaining a position.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8.3 Funding",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Perpetual Contracts may use periodic funding payments or other mechanisms designed to maintain alignment with a reference or underlying price.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "Funding rates may be positive or negative and may change over time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for understanding the funding mechanism applicable to each Perpetual Contract before trading.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8.4 Oracle and Mark Price Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "The value, mark price, index price, or liquidation price of a Perpetual Contract may depend on an oracle, index, or other pricing mechanism.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Errors, manipulation, delays, outages, or other failures affecting such mechanisms may result in unexpected execution, liquidation, or losses.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8.5 Market Suspension and Settlement",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "A Perpetual Contract market may be suspended, halted, settled, modified, or otherwise restricted by the relevant protocol, market operator, or deployer.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell cannot guarantee continued availability or trading of any Perpetual Contract.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "9. THIRD-PARTY PROTOCOLS AND SERVICES",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface may integrate with or provide access to Third-Party Services.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "These may include:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "blockchain networks;")], bullet: true),
  LegalParagraph([TextSpan(text: "decentralized exchanges;")], bullet: true),
  LegalParagraph([TextSpan(text: "liquidity providers;")], bullet: true),
  LegalParagraph([TextSpan(text: "market makers;")], bullet: true),
  LegalParagraph([TextSpan(text: "aggregators;")], bullet: true),
  LegalParagraph([
    TextSpan(text: "Hyperliquid and HIP-3 markets;"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "Tokenized Security issuers;")], bullet: true),
  LegalParagraph([TextSpan(text: "wallets;")], bullet: true),
  LegalParagraph([TextSpan(text: "RPC providers;")], bullet: true),
  LegalParagraph([TextSpan(text: "oracle providers;")], bullet: true),
  LegalParagraph([TextSpan(text: "market-data providers;")], bullet: true),
  LegalParagraph([TextSpan(text: "bridges;")], bullet: true),
  LegalParagraph([TextSpan(text: "infrastructure providers;")], bullet: true),
  LegalParagraph([TextSpan(text: "analytics providers; and")], bullet: true),
  LegalParagraph([
    TextSpan(text: "other third-party applications or protocols."),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Third-Party Services are operated independently from NoBell.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not own, operate, control, or guarantee the performance, availability, accuracy, security, liquidity, pricing, or reliability of Third-Party Services unless expressly stated otherwise.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Your use of Third-Party Services may be subject to separate terms, privacy policies, risk disclosures, and eligibility requirements.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are responsible for reviewing and complying with all applicable third-party terms.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell shall not be responsible for losses arising from or relating to Third-Party Services, including failures, exploits, hacks, smart-contract vulnerabilities, oracle failures, liquidity failures, market suspensions, or changes to third-party protocols.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "10. FEES AND COSTS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "Your use of the Interface may result in fees or costs, including:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. blockchain network fees or gas fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. Protocol fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "3. trading fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "4. liquidity-provider fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "5. aggregator or routing fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "6. bridge fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "7. funding payments;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "8. spreads or price impact; and")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "9. other fees charged by Third-Party Services."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The applicable fees may be displayed through the Interface before a transaction is submitted.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Fees charged by Third-Party Services may change without notice to NoBell.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell may receive fees, rebates, spreads, commissions, liquidity incentives, or other economic benefits from certain transactions, Liquidity Sources, or Third-Party Services.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Where applicable, the Interface may disclose such fees or economic arrangements.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "10.1 Taxes",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for determining, reporting, and paying all taxes, duties, levies, or other governmental charges arising from your use of the Interface or any transaction. The Company does not provide tax advice and may make reports or withhold amounts where required by applicable law.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11. RISK DISCLOSURE",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "You acknowledge that trading digital assets, Tokenized Securities, and Perpetual Contracts involves substantial risks.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You represent that you have sufficient knowledge and experience to understand the relevant risks and that you are capable of evaluating and bearing potential losses.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.1 Market Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(text: "Prices may fluctuate rapidly and unpredictably."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You may lose some or all of the value of an asset or position.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Past performance does not indicate future performance."),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.2 Liquidity Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Liquidity may disappear or become materially reduced during periods of market stress.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You may be unable to buy or sell an asset at your desired price or at all.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.3 Slippage and Price Impact",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Large or illiquid transactions may experience substantial price impact and slippage.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The final execution price may differ materially from the displayed or estimated price.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.4 Blockchain Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Blockchain networks may experience congestion, outages, forks, reorganisations, validator failures, attacks, or other technical failures.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Transactions may be delayed, rejected, reverted, or permanently lost.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.5 Smart Contract Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Smart contracts may contain vulnerabilities, coding errors, design flaws, or exploitable mechanisms.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Use of a smart contract may result in a permanent loss of assets.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.6 Wallet and Private-Key Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for the security of your wallet and private keys.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "If your private keys, seed phrase, device, or authentication credentials are compromised or lost, NoBell may not be able to recover your assets.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.7 Tokenized Securities Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Tokenized Securities may not provide direct ownership of the underlying securities and may not provide the same rights as direct ownership.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Their value may deviate materially from the value of the referenced asset.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The issuer, custodian, underlying asset, redemption mechanism, and regulatory structure may involve risks beyond NoBell’s control.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.8 Perpetual Contract Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Perpetual Contracts may involve leverage, margin calls, funding payments, liquidation, oracle risks, and total loss.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You should not trade Perpetual Contracts unless you fully understand these risks.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.9 Regulatory Risk",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Digital assets, Tokenized Securities, and Perpetual Contracts may be subject to different or evolving regulatory requirements in different jurisdictions.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Regulatory changes may restrict or prohibit access to certain products or services.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.10 No Investment Advice",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Nothing provided through the Interface constitutes investment, financial, legal, tax, or other professional advice.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "NoBell does not recommend that you buy, sell, hold, or otherwise transact in any asset or financial instrument.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are solely responsible for conducting your own research and making your own trading decisions.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "11.11 No Guarantee of Best Execution",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "NoBell may attempt to route transactions to a Liquidity Source based on its applicable routing methodology.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "However, NoBell does not guarantee:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "the best available price;")], bullet: true),
  LegalParagraph([TextSpan(text: "the lowest fees;")], bullet: true),
  LegalParagraph([TextSpan(text: "the lowest slippage;")], bullet: true),
  LegalParagraph([TextSpan(text: "the deepest liquidity;")], bullet: true),
  LegalParagraph([TextSpan(text: "successful execution; or")], bullet: true),
  LegalParagraph([
    TextSpan(text: "execution at any particular price."),
  ], bullet: true),
  LegalParagraph(
    [
      TextSpan(
        text: "11.12 No Guarantee of Availability",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "NoBell may suspend, restrict, modify, or discontinue any asset, market, liquidity source, trading pair, or feature at any time.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "12. PROHIBITED ACTIVITIES",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "You must not use the Interface to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "1. engage in unlawful, fraudulent, deceptive, or prohibited activities;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. violate applicable sanctions or regulatory restrictions;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "3. circumvent geographic or eligibility restrictions;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "4. manipulate markets or trading activity;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "5. engage in wash trading, spoofing, front-running, sandwich attacks, or other abusive conduct;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "6. exploit vulnerabilities in NoBell, any Protocol, blockchain network, or Third-Party Service;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "7. introduce malware or malicious code;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "8. interfere with the operation of the Interface or any underlying network;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "9. use unauthorised bots, scripts, crawlers, or automated systems;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "10. scrape, copy, index, or reproduce Interface data without permission;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "11. impersonate another person or entity;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "12. provide false or misleading information;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "13. use the Interface to facilitate money laundering, terrorist financing, sanctions evasion, or other unlawful activity; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "14. engage in any conduct that, in the Company’s reasonable judgment, creates material legal, regulatory, technical, security, or reputational risk.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Any violation may result in suspension or termination of your access to the Interface.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "13. INTELLECTUAL PROPERTY",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface and all related software, designs, trademarks, logos, text, graphics, images, content, and other materials are owned by the Company or its licensors.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Subject to these Terms, the Company grants you a limited, revocable, non-exclusive, non-transferable, and non-sublicensable licence to access and use the Interface for its intended purpose.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "You must not:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. copy or reproduce the Interface;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. modify or create derivative works;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "3. distribute or commercially exploit the Interface;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "4. reverse engineer or decompile the software;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "5. remove proprietary notices; or")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "6. use automated systems to access the Interface without authorisation.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "All rights not expressly granted are reserved by the Company.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "13.1 Feedback",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "If you submit ideas, suggestions, or other feedback regarding the Interface, you grant the Company a worldwide, perpetual, irrevocable, royalty-free, transferable, and sublicensable right to use, reproduce, modify, distribute, and otherwise exploit that feedback without restriction or compensation to you. This does not permit the Company to identify you publicly without your consent.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "14. MARKETING, REWARDS AND REFERRALS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "NoBell may from time to time offer promotional campaigns, rebates, rewards, referral programmes, trading incentives, or similar benefits (“Rewards”).",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Rewards are promotional in nature and do not constitute interest, yield, investment returns, profit-sharing, or guaranteed income.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may establish eligibility requirements and may modify, suspend, or terminate any Rewards programme at any time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may withhold or deny Rewards where it reasonably believes that the relevant activity is fraudulent, abusive, manipulative, or otherwise inconsistent with the applicable programme or these Terms.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Rewards may have no cash value unless expressly stated otherwise.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "15. INDEMNIFICATION",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "You agree to indemnify, defend, and hold harmless the Company, its affiliates, directors, officers, employees, contractors, agents, and service providers from and against any claims, losses, liabilities, damages, costs, and expenses, including reasonable legal fees, arising out of or relating to:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "1. your access to or use of the Interface;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. your breach of these Terms;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "3. your violation of applicable law;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "4. any transaction initiated or approved by you;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "5. your use of any Third-Party Service; or"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "6. any fraud, negligence, misconduct, or misrepresentation by you.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "This indemnity shall survive termination of these Terms."),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "16. LIMITATION OF LIABILITY",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "To the maximum extent permitted by applicable law, the Company and its affiliates, directors, officers, employees, contractors, agents, and service providers shall not be liable for any indirect, incidental, special, consequential, exemplary, or punitive damages.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "This includes losses relating to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "profits;")], bullet: true),
  LegalParagraph([TextSpan(text: "revenue;")], bullet: true),
  LegalParagraph([TextSpan(text: "goodwill;")], bullet: true),
  LegalParagraph([TextSpan(text: "data;")], bullet: true),
  LegalParagraph([TextSpan(text: "digital assets;")], bullet: true),
  LegalParagraph([TextSpan(text: "trading opportunities;")], bullet: true),
  LegalParagraph([TextSpan(text: "market movements;")], bullet: true),
  LegalParagraph([TextSpan(text: "transaction failures;")], bullet: true),
  LegalParagraph([TextSpan(text: "liquidation;")], bullet: true),
  LegalParagraph([TextSpan(text: "slippage;")], bullet: true),
  LegalParagraph([TextSpan(text: "price differences;")], bullet: true),
  LegalParagraph([TextSpan(text: "smart-contract exploits;")], bullet: true),
  LegalParagraph([TextSpan(text: "blockchain failures;")], bullet: true),
  LegalParagraph([TextSpan(text: "third-party failures;")], bullet: true),
  LegalParagraph([TextSpan(text: "oracle failures;")], bullet: true),
  LegalParagraph([TextSpan(text: "liquidity failures;")], bullet: true),
  LegalParagraph([
    TextSpan(text: "hacking or security incidents; or"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "regulatory changes.")], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company’s aggregate liability arising out of or relating to these Terms or the Interface shall not exceed the greater of:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. USD 100; or")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "2. the total amount actually paid by you to the Company for use of the Interface during the three (3) months preceding the event giving rise to the claim.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Nothing in these Terms excludes or limits liability that cannot lawfully be excluded or limited.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "If applicable law gives you non-waivable consumer rights or remedies, those rights and remedies remain unaffected.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "17. DISCLAIMER OF WARRANTIES",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Interface is provided on an “AS IS” and “AS AVAILABLE” basis.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "To the fullest extent permitted by applicable law, the Company disclaims all warranties, express, implied, statutory, or otherwise, including warranties of:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "merchantability;")], bullet: true),
  LegalParagraph([
    TextSpan(text: "fitness for a particular purpose;"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "accuracy;")], bullet: true),
  LegalParagraph([TextSpan(text: "availability;")], bullet: true),
  LegalParagraph([TextSpan(text: "reliability;")], bullet: true),
  LegalParagraph([TextSpan(text: "security;")], bullet: true),
  LegalParagraph([TextSpan(text: "non-infringement; and")], bullet: true),
  LegalParagraph([TextSpan(text: "title.")], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The Company does not warrant that:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "1. the Interface will always be available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. the Interface will be error-free;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "3. transactions will execute successfully;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "4. displayed prices or market information will be accurate or current;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "5. any asset or market will remain available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "6. any Liquidity Source will remain available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "7. any Tokenized Security will maintain its value or tracking relationship; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "8. any Perpetual Contract will remain available or operate without interruption.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "18. SUSPENSION AND TERMINATION",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Company may suspend or terminate your access to the Interface at any time if it reasonably believes that:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. you have breached these Terms;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. your use violates applicable law;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "3. you are a Prohibited Person;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "4. your activity creates legal, regulatory, security, technical, or reputational risk; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "5. suspension or termination is necessary to protect the Company, its users, or Third-Party Services.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may also suspend or restrict access to particular assets, markets, Liquidity Sources, or features without suspending your entire account or access to the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Upon termination, your right to use the Interface immediately ceases.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Termination does not affect rights or obligations that accrued before termination.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "19. DISPUTE RESOLUTION",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "Except where applicable law requires otherwise, any dispute, controversy, or claim arising out of or relating to these Terms or your use of the Interface (“Dispute”) shall be resolved in accordance with this Section.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Before initiating formal proceedings, you must provide the Company with written notice of the Dispute and a reasonable opportunity to resolve it.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "Notices shall be sent to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "contact@nobell.global")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The notice must include:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "1. your name;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "2. your contact information;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "3. a description of the Dispute; and")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "4. the resolution sought.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "If the Dispute is not resolved within thirty (30) days after receipt of the notice, either party may commence formal proceedings.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "These Terms shall be governed by the laws of "),
    TextSpan(
      text: "Singapore",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: ", without regard to conflict-of-law principles."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Any Dispute not resolved through the above process shall be finally resolved by arbitration administered by the ",
    ),
    TextSpan(
      text: "Singapore International Arbitration Centre (SIAC)",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " in accordance with the SIAC Rules in force when the arbitration is commenced, which rules are incorporated into this Section by reference.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "The seat of arbitration shall be "),
    TextSpan(
      text: "Singapore.",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The arbitration shall be conducted in English before a sole arbitrator unless otherwise required by the applicable arbitration rules.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Nothing in this Section prevents either party from seeking urgent interim or injunctive relief from a court of competent jurisdiction. To the extent a Dispute is not subject to arbitration, the courts of Singapore shall have exclusive jurisdiction, except where applicable law requires otherwise.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "To the maximum extent permitted by law, Disputes shall be resolved on an individual basis and shall not be brought as class, collective, or representative actions.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "20. MISCELLANEOUS",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph(
    [
      TextSpan(
        text: "Entire Agreement",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "These Terms constitute the entire agreement between you and the Company regarding the Interface and supersede all prior or contemporaneous agreements relating to the same subject matter.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Changes",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text:
          "The Company may amend these Terms by publishing an updated version.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Material changes may be communicated through the Interface, website, email, or other reasonable means. Unless otherwise stated, amended Terms take effect when published. Changes will not apply retroactively where prohibited by law.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Your continued use of the Interface after the effective date of amended Terms constitutes acceptance of the amended Terms.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Assignment",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "You may not assign or transfer your rights or obligations under these Terms without the Company’s prior written consent.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may assign these Terms to an affiliate, successor, purchaser, or other entity in connection with a merger, acquisition, restructuring, or transfer of the Company’s business or assets.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Severability",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "If any provision of these Terms is found to be invalid or unenforceable, the remaining provisions shall remain in full force and effect.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "No Waiver",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Failure by the Company to enforce any provision of these Terms shall not constitute a waiver of that provision or any other provision.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Language",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([TextSpan(text: "These Terms are written in English.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Any translation may be provided for convenience only. In the event of any conflict between the English version and a translated version, the English version shall prevail.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Privacy",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Company’s collection and use of personal data in connection with the Interface are described in the privacy notice made available through the Interface or the official NoBell website. Third-Party Services may process personal data under their own privacy notices. You should review those notices before using the relevant Third-Party Service.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Electronic Communications",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "You consent to receive agreements, notices, disclosures, and other communications electronically, including through the Interface, the official NoBell website, or email. You are responsible for keeping your contact details current and for maintaining access to compatible hardware and software.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "App Store Terms",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "If you obtain the Interface through an app store or distribution platform, your use may also be subject to that platform’s terms. To the extent required by those terms, the platform provider is not a party to these Terms and is not responsible for the Interface, support, maintenance, warranties, claims, or intellectual property matters relating to the Interface, except as required by applicable law.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Force Majeure",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "The Company shall not be liable for any delay, interruption, or failure caused by circumstances beyond its reasonable control, including natural disasters, war, terrorism, civil unrest, regulatory actions, strikes, power outages, internet failures, DNS failures, blockchain network failures, validator failures, cyberattacks, network congestion, or other technical or infrastructure failures.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Relationship of the Parties",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Nothing in these Terms creates a partnership, joint venture, agency, employment, fiduciary, brokerage, advisory, or other similar relationship between you and the Company.",
    ),
  ]),
  LegalParagraph([
    TextSpan(
      text: "You act solely on your own behalf and have no authority to bind the Company.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Notices",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Notices to you may be provided through the Interface, the official NoBell website, email, or other communication channels designated by the Company.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Electronic delivery shall constitute written notice to the extent permitted by applicable law.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "Survival",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Provisions concerning intellectual property, risk disclosures, indemnification, limitation of liability, disclaimers, dispute resolution, governing law, and any other provisions that by their nature should survive termination shall survive termination of these Terms.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "21. CONTACT US",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "Questions, complaints, and legal notices regarding these Terms may be sent to:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "TECHNOVA LABS PTE. LTD.",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "3 Fraser Street, #04-23A, DUO Tower")]),
  LegalParagraph([TextSpan(text: "Singapore")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "Email: contact@nobell.global")]),
];

const privacyParagraphs = <LegalParagraph>[
  LegalParagraph(
    [
      TextSpan(
        text: "Privacy Policy",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 20,
    bottom: 8,
  ),
  LegalParagraph(
    [TextSpan(text: "Last Updated: 27 October 2026")],
    size: 12,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "This Privacy Policy explains how TECHNOVA LABS PTE. LTD., operating under the NoBell brand (“NoBell”, “we”, “us”, or “our”), collects, uses, and shares your personal information. We take your privacy seriously and are committed to protecting your personal data.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "1. Information We Collect",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We collect information that you provide directly to us when you:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Create an account or profile"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Use our services, including when conducting transactions"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Communicate with us via email, social media, or other channels",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Complete verification processes"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Respond to surveys or participate in promotions"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "We also automatically collect certain information when you use our services, including:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Device information, such as your operating system, hardware model, and device identifiers",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Log information, such as your IP address, browser type, and pages visited",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Location information when you use our app, if you have granted permission",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text:
          "Blockchain transaction information, which may be publicly available",
    ),
  ], bullet: true),
  LegalParagraph(
    [
      TextSpan(
        text: "2. How We Use Your Information",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "We use the information we collect to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Provide, maintain, and improve our services"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Process transactions and send related information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Verify your identity and comply with regulatory requirements",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Communicate with you about products, services, and events"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Respond to your comments, questions, and requests"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Prevent fraudulent transactions and enhance security"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Monitor and analyse trends, usage, and activities"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Personalise your experience and provide relevant content and features",
    ),
  ], bullet: true),
  LegalParagraph(
    [
      TextSpan(
        text: "3. Information Sharing and Disclosure",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([TextSpan(text: "We may share your information with:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Service providers that perform services on our behalf"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Financial institutions and payment processors that facilitate transactions",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Business partners with whom we offer co-branded services or promotions",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Law enforcement agencies, government officials, or other third parties where required by law",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Other users at your direction, including through publicly available transaction information",
    ),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "We may also share aggregated or de-identified information that cannot reasonably be used to identify you.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "4. Security",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We take reasonable measures to help protect your personal information against loss, theft, misuse, unauthorised access, disclosure, alteration, and destruction. However, no security system is impenetrable, and we cannot guarantee the security of our systems or your information.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "5. Your Rights",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "Depending on your location, you may have certain rights regarding your personal information, including the right to:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Access your personal information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Correct inaccurate or incomplete information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Request the deletion of your personal information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Restrict the processing of your personal information"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "Request data portability")], bullet: true),
  LegalParagraph([
    TextSpan(text: "Object to the processing of your personal information"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "To exercise these rights, please contact us using the details provided in the “Contact Us” section.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "6. Account and Data Deletion",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "You may request the deletion of your NoBell account and associated personal data by sending an email to ",
    ),
    TextSpan(
      text: "contact@nobell.global",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: " with the subject line "),
    TextSpan(
      text: "“Account Deletion Request.”",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Please include the email address registered with your account and any other information reasonably required for us to identify your account and verify that the request was made by the account holder. For security reasons, we may request additional verification before processing the request. You should never provide your private key, seed phrase, or wallet recovery phrase.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Once your request has been verified, we will delete or anonymise your account and associated personal data within 30 days, unless the information must be retained for legal, regulatory, fraud-prevention, security, dispute-resolution, or financial record-keeping purposes.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Information that we are legally required to retain may be kept for up to five years after your account is closed, or for a longer period where required by applicable law. Residual copies stored in backup systems may remain for up to 90 days before being securely deleted or overwritten.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Deleting your NoBell account will not delete transaction information that has already been recorded on a public blockchain. Public blockchain records are not controlled by NoBell and generally cannot be changed or deleted.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7. International Data Transfers",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We may transfer your personal information to countries other than the country in which you live. We implement appropriate safeguards when transferring personal data, as required by applicable law.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8. Changes to This Privacy Policy",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We may update this Privacy Policy from time to time. If we make changes, we will notify you by revising the “Last Updated” date at the top of this Privacy Policy. In some cases, we may also provide additional notice.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "9. Contact Us",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "If you have any questions about this Privacy Policy or wish to submit an account or data deletion request, please contact us at:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Email: "),
    TextSpan(
      text: "contact@nobell.global",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ]),
];
