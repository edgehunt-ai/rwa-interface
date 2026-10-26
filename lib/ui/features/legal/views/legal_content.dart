// Legal copy and typography from the supplied Figma documents.
// Preserve source placeholders until approved replacement copy is supplied.
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
  LegalParagraph([TextSpan(text: "Last Updated: [●]")], size: 12, bottom: 16),
  LegalParagraph([
    TextSpan(
      text: "These Terms of Use (“Terms”) govern your access to and use of the XYZ mobile application, website, software, interfaces, tools, content, and related services made available by or on behalf of ",
    ),
    TextSpan(
      text: "[XYZ Legal Entity Name]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: ", a company incorporated in "),
    TextSpan(
      text: "[Jurisdiction]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(
      text: " (“Company”, “XYZ”, “we”, “us”, or “our”) (collectively, the “Interface”).",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Please read these Terms carefully before accessing or using the Interface. By downloading, accessing, connecting a wallet to, or otherwise using the Interface, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, you must not access or use the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
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
      text: " means any third-party decentralized exchange, liquidity provider, market maker, protocol, trading venue, automated market maker, order book, aggregator, or other source of liquidity or trading quotes accessible through the Interface, including any liquidity provided by XYZ or its affiliates.",
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
      text: "(a) you are at least the age of majority in your jurisdiction of residence;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) you have the legal capacity and authority to enter into these Terms;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(c) your use of the Interface is permitted under all laws and regulations applicable to you; and",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(d) you are not a Prohibited Person.")]),
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
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(a) appears on, or is owned or controlled by a person appearing on, any applicable sanctions or restricted-party list maintained by the United Nations, United States, European Union, United Kingdom, or other applicable governmental authority;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) is located, organised, incorporated, or resident in a jurisdiction subject to comprehensive economic or trade sanctions or other restrictions applicable to the Company;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(c) is otherwise prohibited from accessing or using the Interface under applicable law; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(d) accesses or uses the Interface on behalf of, or for the benefit of, any person described above.",
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
        text: "3. DESCRIPTION OF XYZ",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "XYZ provides a non-custodial mobile trading interface that enables users to access and interact with supported blockchain-based trading markets and protocols.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The Interface may provide access to:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(a) spot trading of digital assets and Tokenized Securities;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) Perpetual Contracts made available through third-party protocols;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(c) liquidity and trading quotes from multiple Liquidity Sources;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(d) market data, asset information, prices, charts, transaction estimates, and other trading-related information; and",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(e) other trading-related functionality introduced by the Company from time to time.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ is not itself the underlying blockchain network or Protocol through which a transaction is ultimately recorded or settled.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Except where expressly stated otherwise in these Terms, XYZ does not take custody of your assets or private keys.",
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
  LegalParagraph([TextSpan(text: "XYZ operates on a non-custodial basis.")]),
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
      text: "Once a blockchain transaction has been signed and submitted, it may be irreversible and may not be capable of being cancelled, reversed, or recovered by XYZ.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You acknowledge that XYZ does not guarantee the successful execution, confirmation, settlement, or reversibility of any transaction.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "You are responsible for maintaining records of your transactions and complying with any tax, reporting, accounting, or regulatory obligations applicable to you.",
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
      text: "XYZ may aggregate trading liquidity and quotes from multiple Liquidity Sources.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Interface may compare available quotes, prices, liquidity, fees, estimated slippage, price impact, and other execution parameters and may route a transaction to a Liquidity Source based on the routing methodology implemented by XYZ.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The routing methodology may take into account factors including:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(a) quoted price;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) available liquidity;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(c) estimated price impact;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(d) fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(e) expected execution quality;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(f) network and protocol conditions;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(g) transaction size;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(h) asset and market availability; and")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(i) other technical or commercial considerations."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Liquidity Source selected by XYZ may change between the time a quote is displayed and the time a transaction is executed.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ does not guarantee that the selected Liquidity Source will provide the best price or best execution available across every market, venue, protocol, or liquidity source.",
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
        text: "5.1 XYZ and Affiliate Liquidity",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "XYZ, its affiliates, or entities associated with XYZ may, from time to time, provide liquidity, submit quotes, participate as a liquidity provider, or otherwise make liquidity available for transactions initiated through the Interface.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Accordingly, XYZ or its affiliates may have an economic interest in the execution of certain transactions.",
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
      text: "Where XYZ or an affiliate provides liquidity, the transaction may be routed to such liquidity in accordance with the applicable routing methodology.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The existence of XYZ or affiliate liquidity does not mean that XYZ guarantees execution at the best price available across all third-party markets or venues.",
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
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "A displayed quote does not constitute a binding offer or guarantee of execution.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "Transactions may:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "• fail;")]),
  LegalParagraph([TextSpan(text: "• revert;")]),
  LegalParagraph([TextSpan(text: "• be delayed;")]),
  LegalParagraph([TextSpan(text: "• be partially executed;")]),
  LegalParagraph([TextSpan(text: "• execute at a different price;")]),
  LegalParagraph([
    TextSpan(text: "• incur greater slippage than estimated; or"),
  ]),
  LegalParagraph([TextSpan(text: "• become unavailable before execution.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ does not guarantee successful execution or any specific execution price.",
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
        text: "7.2 XYZ Is Not the Issuer",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 14,
    top: 16,
    bottom: 12,
  ),
  LegalParagraph([
    TextSpan(
      text: "Unless expressly stated otherwise, XYZ is not the issuer, sponsor, custodian, administrator, broker, transfer agent, or legal owner of the underlying securities associated with any Tokenized Security.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "XYZ does not guarantee:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(a) the existence or value of the underlying security;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) the solvency or performance of the issuer or any relevant intermediary;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(c) the maintenance of any particular backing arrangement;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(d) the ability to redeem a Tokenized Security;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(e) the continued availability of a Tokenized Security; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(f) that the Tokenized Security will trade at or near the value of the underlying security.",
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
  LegalParagraph([TextSpan(text: "• market hours;")]),
  LegalParagraph([TextSpan(text: "• liquidity conditions;")]),
  LegalParagraph([TextSpan(text: "• trading venue differences;")]),
  LegalParagraph([TextSpan(text: "• blockchain activity;")]),
  LegalParagraph([TextSpan(text: "• supply and demand;")]),
  LegalParagraph([TextSpan(text: "• currency conversion;")]),
  LegalParagraph([TextSpan(text: "• fees;")]),
  LegalParagraph([TextSpan(text: "• oracle or pricing mechanisms;")]),
  LegalParagraph([TextSpan(text: "• issuer arrangements;")]),
  LegalParagraph([TextSpan(text: "• market fragmentation; or")]),
  LegalParagraph([TextSpan(text: "• other factors.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ does not guarantee that the price of any Tokenized Security will track the underlying security accurately or continuously.",
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
      text: "XYZ does not guarantee any particular treatment of corporate actions.",
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
  LegalParagraph([TextSpan(text: "• contract specifications;")]),
  LegalParagraph([TextSpan(text: "• oracle mechanisms;")]),
  LegalParagraph([TextSpan(text: "• leverage limits;")]),
  LegalParagraph([TextSpan(text: "• margin requirements;")]),
  LegalParagraph([TextSpan(text: "• funding parameters;")]),
  LegalParagraph([TextSpan(text: "• open interest caps;")]),
  LegalParagraph([TextSpan(text: "• fees;")]),
  LegalParagraph([TextSpan(text: "• market status; and")]),
  LegalParagraph([TextSpan(text: "• trading or settlement mechanisms.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ does not control the underlying protocol or the market deployer.",
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
      text: "XYZ cannot guarantee continued availability or trading of any Perpetual Contract.",
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
  LegalParagraph([TextSpan(text: "• blockchain networks;")]),
  LegalParagraph([TextSpan(text: "• decentralized exchanges;")]),
  LegalParagraph([TextSpan(text: "• liquidity providers;")]),
  LegalParagraph([TextSpan(text: "• market makers;")]),
  LegalParagraph([TextSpan(text: "• aggregators;")]),
  LegalParagraph([TextSpan(text: "• Hyperliquid and HIP-3 markets;")]),
  LegalParagraph([TextSpan(text: "• Tokenized Security issuers;")]),
  LegalParagraph([TextSpan(text: "• wallets;")]),
  LegalParagraph([TextSpan(text: "• RPC providers;")]),
  LegalParagraph([TextSpan(text: "• oracle providers;")]),
  LegalParagraph([TextSpan(text: "• market-data providers;")]),
  LegalParagraph([TextSpan(text: "• bridges;")]),
  LegalParagraph([TextSpan(text: "• infrastructure providers;")]),
  LegalParagraph([TextSpan(text: "• analytics providers; and")]),
  LegalParagraph([
    TextSpan(text: "• other third-party applications or protocols."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "Third-Party Services are operated independently from XYZ."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ does not own, operate, control, or guarantee the performance, availability, accuracy, security, liquidity, pricing, or reliability of Third-Party Services unless expressly stated otherwise.",
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
      text: "XYZ shall not be responsible for losses arising from or relating to Third-Party Services, including failures, exploits, hacks, smart-contract vulnerabilities, oracle failures, liquidity failures, market suspensions, or changes to third-party protocols.",
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
  LegalParagraph([TextSpan(text: "(a) blockchain network fees or gas fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) Protocol fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(c) trading fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(d) liquidity-provider fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(e) aggregator or routing fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(f) bridge fees;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(g) funding payments;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(h) spreads or price impact; and")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(i) other fees charged by Third-Party Services."),
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
      text: "Fees charged by Third-Party Services may change without notice to XYZ.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "XYZ may receive fees, rebates, spreads, commissions, liquidity incentives, or other economic benefits from certain transactions, Liquidity Sources, or Third-Party Services.",
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
      text: "If your private keys, seed phrase, device, or authentication credentials are compromised or lost, XYZ may not be able to recover your assets.",
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
      text: "The issuer, custodian, underlying asset, redemption mechanism, and regulatory structure may involve risks beyond XYZ's control.",
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
      text: "XYZ does not recommend that you buy, sell, hold, or otherwise transact in any asset or financial instrument.",
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
      text: "XYZ may attempt to route transactions to a Liquidity Source based on its applicable routing methodology.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "However, XYZ does not guarantee:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "• the best available price;")]),
  LegalParagraph([TextSpan(text: "• the lowest fees;")]),
  LegalParagraph([TextSpan(text: "• the lowest slippage;")]),
  LegalParagraph([TextSpan(text: "• the deepest liquidity;")]),
  LegalParagraph([TextSpan(text: "• successful execution; or")]),
  LegalParagraph([TextSpan(text: "• execution at any particular price.")]),
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
      text: "XYZ may suspend, restrict, modify, or discontinue any asset, market, liquidity source, trading pair, or feature at any time.",
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
      text: "(a) engage in unlawful, fraudulent, deceptive, or prohibited activities;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) violate applicable sanctions or regulatory restrictions;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(c) circumvent geographic or eligibility restrictions;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(d) manipulate markets or trading activity;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(e) engage in wash trading, spoofing, front-running, sandwich attacks, or other abusive conduct;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(f) exploit vulnerabilities in XYZ, any Protocol, blockchain network, or Third-Party Service;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(g) introduce malware or malicious code;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(h) interfere with the operation of the Interface or any underlying network;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "(i) use unauthorised bots, scripts, crawlers, or automated systems;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(j) scrape, copy, index, or reproduce Interface data without permission;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(k) impersonate another person or entity;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(l) provide false or misleading information;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(m) use the Interface to facilitate money laundering, terrorist financing, sanctions evasion, or other unlawful activity; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(n) engage in any conduct that, in the Company's reasonable judgment, creates material legal, regulatory, technical, security, or reputational risk.",
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
  LegalParagraph([TextSpan(text: "(a) copy or reproduce the Interface;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) modify or create derivative works;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(c) distribute or commercially exploit the Interface;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(d) reverse engineer or decompile the software;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(e) remove proprietary notices; or")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(f) use automated systems to access the Interface without authorisation.",
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
      text: "XYZ may from time to time offer promotional campaigns, rebates, rewards, referral programmes, trading incentives, or similar benefits (“Rewards”).",
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
    TextSpan(text: "(a) your access to or use of the Interface;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) your breach of these Terms;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(c) your violation of applicable law;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(d) any transaction initiated or approved by you;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(e) your use of any Third-Party Service; or"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text:
          "(f) any fraud, negligence, misconduct, or misrepresentation by you.",
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
  LegalParagraph([TextSpan(text: "• profits;")]),
  LegalParagraph([TextSpan(text: "• revenue;")]),
  LegalParagraph([TextSpan(text: "• goodwill;")]),
  LegalParagraph([TextSpan(text: "• data;")]),
  LegalParagraph([TextSpan(text: "• digital assets;")]),
  LegalParagraph([TextSpan(text: "• trading opportunities;")]),
  LegalParagraph([TextSpan(text: "• market movements;")]),
  LegalParagraph([TextSpan(text: "• transaction failures;")]),
  LegalParagraph([TextSpan(text: "• liquidation;")]),
  LegalParagraph([TextSpan(text: "• slippage;")]),
  LegalParagraph([TextSpan(text: "• price differences;")]),
  LegalParagraph([TextSpan(text: "• smart-contract exploits;")]),
  LegalParagraph([TextSpan(text: "• blockchain failures;")]),
  LegalParagraph([TextSpan(text: "• third-party failures;")]),
  LegalParagraph([TextSpan(text: "• oracle failures;")]),
  LegalParagraph([TextSpan(text: "• liquidity failures;")]),
  LegalParagraph([TextSpan(text: "• hacking or security incidents; or")]),
  LegalParagraph([TextSpan(text: "• regulatory changes.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company's aggregate liability arising out of or relating to these Terms or the Interface shall not exceed the greater of:",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(a) USD 100; or")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(b) the total amount actually paid by you to the Company for use of the Interface during the three (3) months preceding the event giving rise to the claim.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Nothing in these Terms excludes or limits liability that cannot lawfully be excluded or limited.",
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
  LegalParagraph([TextSpan(text: "• merchantability;")]),
  LegalParagraph([TextSpan(text: "• fitness for a particular purpose;")]),
  LegalParagraph([TextSpan(text: "• accuracy;")]),
  LegalParagraph([TextSpan(text: "• availability;")]),
  LegalParagraph([TextSpan(text: "• reliability;")]),
  LegalParagraph([TextSpan(text: "• security;")]),
  LegalParagraph([TextSpan(text: "• non-infringement; and")]),
  LegalParagraph([TextSpan(text: "• title.")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The Company does not warrant that:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(a) the Interface will always be available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) the Interface will be error-free;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(c) transactions will execute successfully;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(d) displayed prices or market information will be accurate or current;",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(e) any asset or market will remain available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "(f) any Liquidity Source will remain available;"),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(g) any Tokenized Security will maintain its value or tracking relationship; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(h) any Perpetual Contract will remain available or operate without interruption.",
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
  LegalParagraph([TextSpan(text: "(a) you have breached these Terms;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) your use violates applicable law;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(c) you are a Prohibited Person;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(d) your activity creates legal, regulatory, security, technical, or reputational risk; or",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "(e) suspension or termination is necessary to protect the Company, its users, or Third-Party Services.",
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
  LegalParagraph([
    TextSpan(
      text: "[Legal / Compliance Email]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "The notice must include:")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(a) your name;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(b) your contact information;")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(c) a description of the Dispute; and")]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([TextSpan(text: "(d) the resolution sought.")]),
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
      text: "[Governing Law Jurisdiction]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: ", without regard to conflict-of-law principles."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "Any Dispute not resolved through the above process shall be finally resolved by arbitration administered by ",
    ),
    TextSpan(
      text: "[Arbitration Institution]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: " in accordance with its applicable rules."),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(text: "The seat of arbitration shall be "),
    TextSpan(
      text: "[Arbitration Seat]",
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    TextSpan(text: "."),
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
      text: "Material changes may be communicated through the Interface, website, or other reasonable means.",
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
      text: "You may not assign or transfer your rights or obligations under these Terms without the Company's prior written consent.",
    ),
  ]),
  LegalParagraph([TextSpan(text: "​")]),
  LegalParagraph([
    TextSpan(
      text: "The Company may assign these Terms to an affiliate, successor, purchaser, or other entity in connection with a merger, acquisition, restructuring, or transfer of the Company's business or assets.",
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
  LegalParagraph([TextSpan(text: "​")]),
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
      text: "Notices to you may be provided through the Interface, the official XYZ website, email, or other communication channels designated by the Company.",
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
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "This Privacy Policy explains how Nobell collects, uses, and shares your personal information. We take your privacy seriously and are committed to protecting your personal data.",
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
      text: "We collect information you provide directly to us when you:",
    ),
    TextSpan(text: "\n"),
  ]),
  LegalParagraph([
    TextSpan(text: "Create an account or profile"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Use our services, including transaction data"),
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
    TextSpan(text: "\n"),
  ]),
  LegalParagraph([
    TextSpan(
      text: "Device information (operating system, hardware model, device identifiers)",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Log information (IP address, browser type, pages visited)"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Location information when you use our app (if you've granted permission)",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Blockchain transaction information (which is publicly available)",
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
  LegalParagraph([
    TextSpan(text: "We use the information we collect to:"),
    TextSpan(text: "\n"),
  ]),
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
    TextSpan(text: "Monitor and analyze trends, usage, and activities"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Personalize your experience and provide content and features",
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
  LegalParagraph([
    TextSpan(text: "We may share your information with:"),
    TextSpan(text: "\n"),
  ]),
  LegalParagraph([
    TextSpan(text: "Service providers who perform services on our behalf"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Financial institutions and payment processors to facilitate transactions",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Business partners with whom we offer co-branded services or promotions",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Law enforcement, government officials, or other third parties when required by law",
    ),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "Other users as directed by you (such as public transaction information)",
    ),
    TextSpan(text: "\n"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "We may also share aggregated or de-identified information, which cannot reasonably be used to identify you.",
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
      text: "We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. However, no security system is impenetrable, and we cannot guarantee the security of our systems or your information.",
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
      text: "Depending on your location, you may have certain rights regarding your personal information, including:",
    ),
    TextSpan(text: "\n"),
  ]),
  LegalParagraph([
    TextSpan(text: "Access to your personal information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Correction of inaccurate or incomplete information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Deletion of your personal information"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(text: "Restriction of processing of your personal information"),
  ], bullet: true),
  LegalParagraph([TextSpan(text: "Data portability")], bullet: true),
  LegalParagraph([
    TextSpan(text: "Objection to processing"),
    TextSpan(text: "\n"),
  ], bullet: true),
  LegalParagraph([
    TextSpan(
      text: "To exercise these rights, please contact us using the details provided in the \"Contact Us\" section.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "6. International Data Transfers",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We may transfer your personal information to countries other than the one in which you live. We deploy appropriate safeguards when we transfer personal data.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "7. Changes to this Privacy Policy",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "We may change this Privacy Policy from time to time. If we make changes, we will notify you by revising the date at the top of the policy and, in some cases, we may provide you with additional notice.",
    ),
  ]),
  LegalParagraph(
    [
      TextSpan(
        text: "8. Contact Us",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
    size: 15,
    top: 24,
    bottom: 16,
  ),
  LegalParagraph([
    TextSpan(
      text: "If you have any questions about this Privacy Policy, please contact us at xxx mail.",
    ),
  ]),
];
