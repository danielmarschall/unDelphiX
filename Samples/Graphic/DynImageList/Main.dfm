object MainForm: TMainForm
  Left = 201
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DelphiX Sample'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object DXDraw: TDXDraw
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    AutoInitialize = True
    AutoSize = False
    Color = clBtnFace
    Display.FixedBitCount = False
    Display.FixedRatio = True
    Display.FixedSize = False
    Options = [doAllowReboot, doWaitVBlank, doCenter, doFlip, do3D, doDirectX7Mode, doHardware]
    OnFinalize = DXDrawFinalize
    OnInitialize = DXDrawInitialize
    Align = alClient
    TabOrder = 0
    Traces = <>
  end
  object ImageList: TDXImageList
    DXDraw = DXDraw
    Items.ColorTable = {
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000}
    Items = <
      item
        PatternHeight = 0
        PatternWidth = 0
        Picture.Data = {
          045444494228000000000100008000000001000800010000002C1F0000000000
          0000000000000000000000000000000000000800000800000008080000100000
          0010080000101000001800000010100800180800001810000021000000210800
          0021100800290000002908000018181800291808003108000031080800291810
          0031100000292110003118080039080000391800004208000031291800422108
          004A1000004A1008004A18080052100000423118005A10000052290800424229
          0063180000631808005A311800632910006B1800006B1808006B2100005A3921
          006B210800633910006B29100073210800732110006B3910005A4A31007B2108
          00733918007B3108007B311000734218008421000084210800842908005A5A39
          0084311000734A29008C210800843910008C2910008C31180094290800636342
          00942910007B5231008C42180094311000735A39008C42210063634A007B4A42
          009C2910009C31100073634200845239008C5221009C3910006B6B4A009C3918
          009C421000A5391000845A4A00A53918009C4A2100945A2100AD3108009C5A29
          00AD42180094633900A54A31009C6321008C6B4200B5391000B5391800AD4A29
          00B5421800B5422100A5632900B54A10007B7B5A00B54A1800A5633100BD3910
          00BD391800B5522100BD421800A56B3100B55A10008C7B5200BD4A1800B55231
          009C734A00A5635200C6421800BD523100C64A1800C64A2100A57B3900C65218
          008C846300CE421000C65A2100CE4A1800B5733100CE4A2100CE520800C66318
          00CE5218009C845A00CE522100AD7B4A00CE522900CE5A2100848C7B00CE5A29
          00D64A2100D6520800C6634200CE632100D6521800BD7B3100D65221009C8C63
          00CE6B0800D65A1800D65A2100DE4A1000B5844A00C6733900D6632100DE5221
          00CE732900DE5A1800D66B2100DE5A2100DE5A2900D6731000C6843900DE6318
          00B5846300DE632100E7521800B58C5A00DE632900E7522100CE734A00DE6B18
          00C68C3900DE6B2100E75A2100D67B2900C68C4200E7631800949C8400DE7321
          00E7632100E7632900CE8C3900E7633100D6843100EF5A1800E76B2900DE7B29
          00EF5A2900EF631000D68C3100EF632100DE842900EF632900D68C3900E77331
          00EF6B1800EF6B2100D6943900DE8C3100EF6B3900F7632100F7632900EF7331
          00F7633100D6944A00EF7B2100F76B2100DE943100EF7B2900F76B2900EF8408
          00F7731800EF734A00E7942100EF7B4200FF632900EF843900FF6B2100FF6B29
          00F7734200FF6B3100FF732900FF733100FF7B1800FF7B2100FF733900FF7B29
          00CEA57300FF841000DE946B00FF7B3100E79C4A00FF841800EF944200EF8C52
          00F7844A00EF9C3100FF8C1800BDAD8C00FF7B4A00FF941000FF845200FF9C10
          00B5B59C00E7AD5A00EFA55A00FFA52900E7AD6B00F7A55A00FF9C5A00FFAD39
          00E7B57300FFB56B00FFC67B00FF0001000000FF0001000000FF0001000000FF
          0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF0001
          000000FF0001000000FF0001000000FF0001000000FF0001000000FF00010000
          00FF0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF
          0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF0001
          000000FF0001000000FF0001000000FF0001000000FF0001000000FF00010000
          00FF0001000000FF000100000071000003051C17000717010C84000000710000
          03055A4700063700032D120000830000007100000B0960B95D58565858562A0F
          00840000007100000B0560BFAE7C797379632A0E00840000007100000B0967BF
          B4A6A09685652A0E00840000007100000B0960B9AEA4A0A0856F2A0E00840000
          007100000B0967BFB4A6A0A085772A0B00840000007100000B0967BFB4A6A0A0
          93772A0B00840000007100000B0967BFB4A6A0A09379340B0084000000710000
          0B0A67BFB4A6A0A097793A0B00840000004E0002030003050302001E00000B0A
          67BFB4A6A0A0A0793F0B00050004037B0000001A00000302171100111100030D
          0905001800000E010816212328282F282823190A020B0000030A171100071101
          04040000170A67BFB4A6A0A0A0803F0B0000081B2727282828231509000B0000
          030217110008110102070000030A171100071101150400000302171100081100
          04040A0808060D031101040F00090803050104160000001A0000030251470011
          37022F00052823190A020013000011162C3E38474252545452523D3D30231502
          0009000003177040000637001F410B000000000A67BFB4A6A0A0A080450B0824
          3E4A47545252483D3B2D1F090009000003032E5C00063700033D340200070000
          030D5A5900063700093D200000000005236700063700093D340415407140373D
          00053700032F1D00000D00000308334F000628022F000342410200160000001A
          000004025AC85D0954025801540258025402520007483D412D1F1502000F0000
          140833495059555D6A6A7373736A655D52483B26090800000B17929D5D5D5858
          5D79450B000400001A0A67BFB4A6A0A0A0934E1C44615C595D6A6A73655D564E
          412D150800000C0332B7845D5D58585D7734020700000B0D5AC86E5858585D73
          6F2000040000110527AD9D5D5D58585D6F3A04042395F27C00045D0005555248
          2A0F000C00000E032469864740405252525DA99C12170000001A00000A025AD1
          B47C6A7373736A0B7300096A655D56483D301F0C000D000009103C615C596A73
          7C970004A0000997857C7365523B260F000700000B1792C19F7C7C7CA082450B
          000400001C0A67BFB4A6A0A0A0935B5161596E7F8A9797978585796A5648301D
          020600000C0335C3BC8A797C7CAF7734020700000B115AC8B485797987A16F20
          000400001B0523A3C19B7C7979A0823A04000A2FD4EFD596857C737365412204
          000B00000D165394816E5D6A6A73A6E0D93000180000001A000005025AD1B4AE
          00099706A0000B97918793796A564E412D15000B0000181653726B6E7F87A0C0
          D3D3DFDFDFD0C0B5978573563B260C0600000B1CA3C8AEA6A0A0AF8D4D0B0004
          00001C0A70C8B4A6A0A0A093656B6E7F97B5CBD3D0D0C0A097857965523B1806
          00000C0335C3BCAEA0A0A0AF7934020700000B115AC8B4C6A0A0AFBD6F200004
          00001B0527A3C1AEA6A0A0AF823A0400001955F2EFE1B5A0978579633B1D000A
          00000E083394887F8A8A97A0C2E0DE6D04180000001A000020025CE9D2AEA0A0
          A0B5B5B5C0C0C6C0C6D0D0C0C0C0B59E9E8579736556412D120900001A033C94
          6B6E7387A0C0DCE8E8E4E4E2E2E2D0B5977A6F633D26040500000B1781C1AEA6
          9EA0A080450B000400001D0967C3B4A6A0A0A1A18C788AA0D3E0E4DFE4E4DBD0
          B59685796548300F000500000C032EB7BCBBB6B6B6A17734020700000B0D51C3
          9FA4A0A0A09C6320000400001C0527B1DABBA6A0A0A0793A040000042395F2EF
          C59E9E917965482A0B0900000D2469867F7F9796A0B5DCDEAA1A00190000001A
          00000D025AD1B4A6A09797C0DFDFE4DF0007E4000DE2DBD0C5B5969387736548
          300C000800001A247D886E7F97A0D3E0E8E0DCBABABAD5EAE2D0B5A0937A5834
          1D050000041781B0AE04A0000380450B000400001E0967C8BCA6A6B6B6A07F97
          C0DEE0DCCACADBD5E1E2DBB5968579654826020400000C0338CEBCBBA6A0A0A1
          7734020700000B0A51BFB4A69EA0A09C6220000400001D0527B1BCAEA6A0A0A0
          793A04000000152FD4F2EAC59E968579623B2204000700000D165386707F8A97
          A0A0CBDED93A001A0000001A0000050251C8B4A60004A001C00ADB03E2000BDB
          D5C59E97877A653D2607000600001C086986817F8AA0C2DCE0DEAA5B3F394383
          F2EFE2C6A0A0A0795626070400000B1781B09F97A0A0A080450B000400001E09
          60BFB4A6A6A0A697A0C2E0E0BA7E5B5B7EBEF2EFE1C59E968579563A12040000
          0C0338CEBCBBA0A0A0AF7734020700000B0A51BF9F9BA09EA09C622000040000
          050527A3B09F0004A00003793A07000400000D1955F2F2E1B29E9E856F56341D
          000600000E06337D887F8A97A097C0DEDE6F071A0000001A00000B025AC8B4A6
          97A097A0876C00067E0298000FA7BAD5E6EAE1D5C5A6917973563B1A00060000
          1C2486997F8A97AFCBDED97729070000001271F4CFA09797A0A0874118040000
          0B1781B09F97A0A0A082450B00040000270960B9AE9B97A0AFC2D3E0E0AF3F18
          0707183BA2F2EFE1C5A09685734E29020000000332ADB09F0004A00003793402
          000700000B0A51BFB4A6969EA09C622000040000050527A3B0AE0004A0000379
          3A04000400000E052095F2EFD59E9E96796F4E2A0C0500000D2469887F7F9797
          A0B5DCDEAA1D001B0000001A00000C025CC7BCBBA9A1A1A1874520051800121A
          1D2029438EE6F2EAD5C59E91796F54310F0500000B4FA89A8A8AA0C2CBCB7E22
          000600011902CF0017A0AFC0D3DCDCBD41040000001781B9AE9BA0A0A080430B
          000400000E0960B99FA6A0A0B6E0E3E3CD30020400001C0222A2F4E2D5A69693
          87653A0B0000000332B7B0AEA9A9B6B88234020700000B0D51BF9FA49EA0A09C
          6220000400000C0527B1C8BCA9A9A1A17A3A040500001E1530D4F2EAC59E9E91
          79683F2204000000106986818C8C8CA0A9DEE0CD411C0000001A00000C025CE9
          EBD8D8DDD8DDB854120A00000D125BD4F2E1C5B597877A66481E000400000C10
          86E5B9C4C9C9C9CDA13A040700001971D0BAA77E6C5B43341E0F0000001BB1EB
          D8C9CCCCB682450B000400000D0960B9AEA6A0A0C2E3E3C94802000600001B02
          47F8F8E4C6A097936F45180000000332B7B0BBB6B8C9DD8C4202000700000B0D
          5CC8B4A69EA0AF9C6320000400000C0527B1C3D8C9D6DDDDA148070600001D19
          55F2F2EAC59E9E916F56341D0000084B94A8ABD6D6DDDDE3F1E3890C001C0000
          001A000004025EFEFB04F30004F1C95D150B00001B0255F4EFD5C5A097878964
          420D00000024E5F9ECEDEDF1F1A1631E00080000072339291D120B0400070000
          0B1BE5FAFBEDF1CCB682450B000400000C0A60B9AE9BA0A1CDE3E3891E080000
          1A21E9FCD2C6A0A0939356260000000332B7B0BBC9DDF1F1C942020700000B14
          5CC8B4A6A0A0A093632000040000050527CEF7FB0004F30003C9540700060000
          1C092595F2EFE1B29EA0856F56300F0024B3E5ECECF3F3F3EDF3F3DD281D0000
          001A00000C0388FFFAFBF3F3EDDDC966150C00001A15A2F4D5C5A6A1B8C98F5F
          1E00000033E5F9FBF3F3F1C9874E110803020502030108051001080300000B21
          FDFEFBEDDDA9A182450B000400000C0960B9AEA6A0B6DDF1DD64040800001A14
          A3FCCFC6A6A0A09365340200000332B7BCD8F1F3F3F3D642020700000B0D51C3
          BCA6A0A0A09C63200004000005052CF9FEFB0004F30003B84207000700001B15
          36D4F2EFD59E9E9679654826168BF0E7ECF3F3F3EDEDF3F36402001D0000001A
          00000503A5FFFBDA0004F10003C96415000D00001855F4EAC5A6A9DDF1D67828
          02000033F9F7ECF1C9C4A189420A28012F022800153E5057574C5F1E0000001B
          E5FADAC4B6B6B687450B000400000B0967B9AE9B97C9F3F1C937000900001A03
          4AFCD2B4A6A0A0936530040000032EB7C8EDF3F3F3D6B842020700000B0D5CD1
          BCAEA0A0A0936320000400000C0833FDFEFBD6F1F1F1B854070700001A021955
          F2F2EAC59E9E917963414CF5E5ECD6D8F1EDF3F3EDA1131E0000001A00000C03
          A8FEEBBBA9DDF1C9B863130D00001D1CD7EFC5AECCF1F1C978310400003EF6FA
          DAC9B8A1A1785F5F5955545500055202550016598FAB8F8F8F66120000001BCE
          EBC4A9A9CCDEA1540C0400000B0960B9AEA6A0DDF3F18C31000A00001938FCDA
          CCCCB6A0A06F340400000332B1EBFBF3F1E3B8894202000700000B145EE9DABB
          A6A0A0936320000400000C0849FDFAEDC4A9C9F1A1480708000018092395F2EF
          E1C59E96856F5D76E5ECD6C9A9C4EDEDEDC9311F0000001A00000C035EC7D2A6
          A0A9A9A1A1480F0D00001C0AA2EFB4C6C4C4B88C66410B000038E9DABCA9B6B6
          8CB8B8B8A98A8707850017878CB8B89BA1C2630F0000001699C8BBBBB6CCC9B8
          580C000400000B0967B9AEA6A9C4CCA1631E000A0000192EE9EBD8CCB6A0A079
          3F070000022EB1DAC4C4A9B6A17A3402000700000B145EF7DAD2A6A0AF936320
          000400000C032CCEC3BCA697A1B67A4107090000171536D4F2EFE1B2A0A0857A
          749A8C9BA997B6E0E3DE5402001F0000001A0000050251C8B4A60004A0000387
          450F000D00001A0271F8CFC5A697A0936F4512000047EEBCAE9BA0A0CCE3E3E0
          BB04C001B503AF02B501A002970013A0A19C4E0C00000017A3B9AEA6B6C9E3A1
          4E0B000400000B0960B9AEA6A0A0A087561D000A0000193EF7EBE8BBA6AFA193
          560F00000232B7B09F9797A0A06F4504000700000B1488FADAAEA6A0AF9C621D
          000400000C0323A3B0AEA6A0A0A0793A0709000016021F68F2F2EAD59EA09779
          737F8AA0A0AFD3E0DE7712200000001A000005025AD1B4A60004A0000393450F
          000E0000175AF8CFC5A6A0A0A079561A00002FEECFAE9B97A0AFCCE80007E401
          DF03E40017D0B5A0A0AFC2934E0B0000001781B09FA6A0B6B687450B00040000
          0B0967B9AEA6A0A0A0936320000A0000123ECEBCAEA6A0AFA18D4D0700000232
          B7BCAE04A00003773A04000700000B1181C7BCAEA6A0AF9C621D000400000C03
          23A3C1AEA0A0A0AF803A070A0000140C2395F2F2E1C59EA0917C97A0A0AFCBDE
          DEBD2A210000001A000005025AD1B4A60004A0000393450F000E00001840EECF
          ACA4A0A0A0825B1D000023D7CFACA6A0A0A0A19C9804A701BA04A70018D0CFC5
          A0A0B5C29C560B0000001792B09FA6A0A0AF82450B0400000B0A67BFAEA6A0A0
          A0825B1D0009000013023E99B09BA6A0B5BD8D410400000232B7BCAE0004A000
          03774107000700000B1170D1B4A6A0A0A19C6326000400000C0323A3BCAEA6A0
          A0AF793A070B000013153DD4F2EFE1B2A09E91A0A0A0C2DCDED94E0400210000
          001A000005025AD1B4A60004A0000393430F000E00003940D1CFACA6A0A0A080
          561D000023F8CFC5A6A0A0AF9C5629252525292925252536C8CFC5A0A0C2BD8D
          3A020000001792B9AEA6A0A0AF82450B020400000B0967BFAEA6A0A093825626
          00090000130661B19D9BA0AFB5C29C450400000232B7BCAE0004A000036F410B
          000700000B1767D1B4A6A6A0A19C6322000400000C0323A3BCAEA6A0A0AF803F
          070B000008021C68F2F2EAD5B204A00006C0DCE0DE7E18220000001A00000C02
          5AD1B4A4A6A0A0AF93430F0E00001832EECFACA6A0A0AF82561D000015C1EFC5
          C5A0A0A0804E180800000A2C99B0AEA6AFC2BD802A0400000B1792C1AEA6A0A0
          AF82450B000400000C0967BFB4A6A0A093804E2A07080000131B72999D9BA0B5
          C2C2AA3A0000000232B7BCAE0004A00003794512000700000B1770C3B4A6A0AF
          C2A16326000400000C0323A3C1AEA69EA0AF803F070C0000100A2B95F4EFEAD5
          A0A0A0B5D3E0DEA12A230000001A000005025AD1B4A40004A0000393430F000E
          00001938D1BCACA4A0A0AF9C632A00000271F8D5C5A0A0917945220200060000
          0B034FA8849BA0C0CBCB8220000400000B1792C1AEA6A0A0AF80450B00040000
          0C0967B9B4A696A0856F5634180700001B033C949A909BA0C0CBBD8222000000
          0232ADBCAEA0A0978773411D000700000B1B7BB79FA6A0AFC2A1652000040000
          0C0323A3B0AEA6A0A0AF803F070D00000F153DD4F2EFE1C5A0AFCBE0DED94E04
          00230000001A00000C025AC8B4AEA6A0A0A093430F0E00001951D1B49BA4A0A0
          AF93632200000055F4EAD5B5A0917956300F000600000B247D88848AA0CBDCBD
          6312000400000B1792C1AEA6A0A0AF80450B000400000D0967B9AEA6969E9779
          654E300F000600001C2169887F8AA0B5CBDCCB77180000000232B7B0AEA0A093
          7965482D0C0600000B2486A39FA6A0AFC2AF6320000400000C0323A3B0AEA6A0
          A0AF8041070D00000E05338688849096A0A08779634120240000001A00000C02
          5AC8B4AEA09E9EA093430F0E00002A38C7B0A6A4A0A0AF93632000000019D4F4
          E1C5A0977965482D15020000031B5375678A97B5D3DCAA3A020400000B1792C1
          AEA6A0A0AF80450B00040000400960B9AEA6A09EA09685654E30150500030821
          4F756B7F8AA0C0DCDCBD4E040000000232B7B0AEA0A0A091795D482D15020000
          0016538681909BA0C0C2AF631D0400000C0323A3BCAEA6A0A0AF803F070D0000
          0F1B6986677F97A0A0A091796341250F00230000001A000005025AD1B4A61504
          A0000393430F370E00000B51B7BCA6A6A0AFA19C6322280400001A55F4EAE1C5
          A09179563D30231C1C2C465E677F97B5D3DED98D1D0500000B1792C8AEA6A0A0
          AF82450B140400001E0960B9AEA6A0A0A096969673523B2D232835465E677F8A
          A0B5DCDEDE8D22040000050232B7BCAEB405A0001491734E3B231C1C233E6170
          7F8A97B5C0CBBD630F0400000C0323A3BCAEA6A0A0AF803F070C000006084494
          707F8A05A00006856F563A2004220000001A00000C025AD1B4AEA0A0A0AF9343
          0F0E00000B51B79D9BA6A0AFC293561D400400001A1FD4F4EAD5B5A085735D52
          3D3D424A596E738AA0D3E0DEBD4E040500000B1792C1AEA6A0A0AF82450B3C04
          0000050A60B9AEA4A004A0017102960012735D52525447596E6E8A97B5D3E0E0
          CB6D070400001E0232B7BCAEA0A09EA0C5C59E795D483D404259596E7F97A0C0
          DCDEBD4D020400000C0323A3C1AEA6A0A0AF803F070B00001201247D887F8A96
          9EA0B5A0A09780654E3018220000001A000005025AC8B4AED404A0000393430F
          650D00000C0561B79DA6A6A0B5C29C63180500001836D4EFEAD5C6A091796A5D
          5D5D6A6A7C96B5D3E0E0D962180600000B1792B9AEA6A0A0AF82450B53040000
          1D0960B9AEA6A0A0A09347F2D5A685736A6A6A737C97A0C0D3E0E0DE7720AF05
          0000050232B7BCAE7004A00014AFF2EAB285736A5D5D6A737F97A0C0D3DEDEAA
          2A0500000C0323A3BCAEA6A0A0AF793A070B0000131B6986677F97A0A0B5D0C6
          A0A091796341250B27210000001A00000C025AD1B4AEA0A0A0AF93430F0D0000
          0C1675B1909BA0AFC2BD9C4D0F050000170255F4F2EAE2D0B5A0968785859797
          B5C0DCE0E0D99C26C00700000B1792B9AEA6A0A0AF82450B650400001C0967BF
          AEA6A0A0A09352A2EADBC0A097969697A0B5CADFE0E0E0BD30060000050232B7
          BCAEAE05A000137CD4EFD5B29797879197A0C0D3DFE0E0DE63078A0500000C03
          23A3BCAEB5B5B5AF803F070A000015083C94817F97A0A0A0C0DFE2B5A0A08579
          563B1D029F200000001A000005025AC8B4AE2704A0000393450F790D00000C24
          86A3909BA0B5C2BD9C4104060000150452D4F2EAE2DBD0D0C6C0C0D0D3DFE0E8
          E0D97726000800000B1792C1AEA6A0A0AF82450B740400001C0967BFB4DFD0C0
          B5933B95E6EAE2DBD0C6D0D0D3DFDFE8E0E0AA3A04060000050232B7BCAEB505
          A000124E55E6EAE2DBD0C6C6D0DCDFE8E8E8DE8D1D0600000C0323A3B0D3DFDF
          DFD3803A070A000015247D887F8A97A0A0C0DCE4EFD5B5A0A0856F482A12BC20
          0000001A00000C025AD1B4AEA6A0A0AF93450F0C00000D0353A89A909BA0C2D3
          C28234027907000008023BBEE6E1E1E2E204E402E80005E0DCAA6C1D0D090000
          0B1792C1AEA6A0A0AF82450B00040000030967C85105E40008A02A1F83E6E1E2
          E204E401E802E00004DC9C2A02070000060232B7BCAEA604A00011452B68BEE1
          E2E2E4E4E4E8E8E0E0DC7E2056070000040323A3D205E40003AF3F0745090000
          171669867F8A97A0A0B5D3E0E4EFE2C6A0A0977965412607E11F0000001A0000
          05025AD1B4A63804A0000393430F770C00000C247D998C8A97AFC2D9CB771D0A
          00000412438EBE06DB02CA0004A76C29070A00000B1792C1AEA6A0A0AF82450B
          6F040000030959A70E06BA000743020F3F8EBED5DE04DB02CA0003AA43180B09
          000005022EB7BCAE8704A000079C41021D438EBEE605DB02CA000398430F3B08
          000006032390BABABA04A700035607002907000018033394817F97A0A0B5CBDC
          DEC0F4EFEAC6A0A0917356341D1F0000001A00000C025AC8B4AEA6A0A0A09343
          0F0B00000D1B6986818A97A0C2CBD9BD560F290C00000C18295B6C6C7E7E6C5B
          3A1D070C00000B1792C8AEA6A0AFAF82450F0004000105032506290104020000
          0B12395B6C7E7E6C5B341802000A0000050232B7BCAE0004A0000F9C41000007
          1D395B6C7E7E6C5B3412000A000003021925000725000322040000070000191B
          7D887F97A0A0A0C2DCDEBD3BA2F4EFE2B5A0A0856F482A0F001E0000001A0000
          0C025AD1B4AEA6A0A0AF93430F0900000F031B4975887F8A97B5D3DED9AA2A02
          000F00000602070C0704020F00000B1792C1AEA6A0AFAF82450F001400010702
          0B01040E000005022EB7BCAE0004A000039C4100000400000502040B0B040020
          00001B085394788AA0A0A0C2DCE0CB4E0C36F2EFEFCFB5A0A079653F2204001D
          0000001A000023025AD1B4AEA6A0A0AF9345110A08060808080D111C2C465E6B
          6E8A97A0C2DCDED96318002500000B1792C8AEA6A0A0AF82450F002600000B02
          32B7BCAEA0A0A0AF93410017000103021C081701040600001C032494817FA0A0
          A0B5DCDEDE820C001568F4EFEAD0A0A0977956341D1D0000001A00000C025AD1
          B4C6A0A0A0AF933D37052F01370235024A015C026E000A7F97A0C2DCE0DEBD34
          022500000B1792C8AEA6A0A0AF82450B002600000B0232C7BCAEA6A0A0AF9341
          001700000C032381403D3D3737373D3A070600001D1B7D887F97A0AFB5D3DCDE
          A1260000022395F4EFEAC6A0A0916F4E2A0F001C0000001A00000B025AD1B4AE
          A6A0A0A065550007540155035D000C6E7F8797A0D3DCE0E0D94E0F2600000B17
          A3C8AEA6A0A0AF8D450F002600000B0232C7BCAEA0A0A0AF8741001700000403
          23A39D055D0003793F07000500000D0844947F8AA0A0B5D3DCDECB4E00040000
          0E0C30D4F4EFE2B5A0A08765411E021B0000001A00000C025CD1BBAEA0A0A07C
          737373076A0273027C02970008AFD3DFE0E0DE7E202700000B1781C8AEA6A0A0
          AF82450B002600000B022EB1BCAEA6B6B5A1803A001700000C0323ADDAAE877C
          7CA0823F070400000E01247D707F97A0A0C0DCDEDE770C0500000D1955F4EFEA
          D5B5A09779633418001B0000001A00000C0367D1B4AEA0A0A097979191068503
          91000B969EB5C0D3E0E3E3DE9C22002800000B1781B0AEA6A0A0A080450B0026
          00000B022ECEBCBBA9A0A0AF793400170000050327B1C8AE0004A00003803A07
          000400000D1669887F8A96A0AFCBDCDE9C26000600000E022395F4EFEAC5A0A0
          916F4E26071A0000001A000005025AC8B4C60006C007B503C002D002DF0007E0
          E8E3DE822602002800000B1781B0AEA6B5A0A079410B002600000B022ECEBCBB
          B5B5A0A0773400170000050327ADB0AE0004A00014793A070000000633946E7F
          A0C0CACADCDCCB41020700000E0C2FD4F4EFE1C6B5A085653F1D02190000001A
          000004025AC8B412DF02E402DF0004DCBD5B1D2A00000B1781B9B4DFDFDFBB80
          450B002600000B022EB7B0D3DFDFDFB56F3400170000140323A3BCC6DFDFDFC2
          823F070000001B7D709BD304DF0004DCD96D0C0900000D1552F2F2E2DFDBD0D0
          A065301200190000001A000003025CDA000EE405DF02DC0005D9AA6C2A0B002B
          00000B1781C4E4DFE4E4DFAF450B002600000B022EB7D2E4E4E8E8E882300017
          0000040323ADCC05E80009A03A070000104B88BB0004DB02CA0003D99C20000A
          00000E041F71F4E4DFDFDFE4DFDF872A04180000001A00000A035CD3D3DCDCDE
          DEDCDC04CB01D903CA02BA0007A7987E6C43220B002D000003169AC00004CA02
          BA0003620B00002500000C022E9BA7BABAC0CBD3CB42021600000403239FBA04
          CB0008D3CB650700083374047E026C037E00033F0200000A0000051135D2D9CB
          0006CA0003A7340000170000001A00000A02263030303737373B340430000A34
          302A2922221D180F043000000B11302D3030302D2925250C002700011D022202
          25012A042D01021600001A021525262D2D2D302F302D0700031515151D1A1A1A
          1D1D20200C0D000116022D0126041F00051D151212040017000000FF00010000
          00FF0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF
          0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF0001
          000000FF0001000000FF0001000000FF0001000000FF0001000000FF00010000
          00FF0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF
          0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF0001
          000000FF0001000000FF0001000000FF0001000000FF0001000000FF00010000
          00FF0001000000FF0001000000FF0001000000FF0001000000FF0001000000FF
          0001000000FF0001000000FF0001000000FF00010000000001}
        SystemMemory = False
        Transparent = True
        TransparentColor = clBlack
      end>
    Left = 32
    Top = 24
  end
  object DXTimer: TDXTimer
    ActiveOnly = True
    Enabled = False
    Interval = 0
    OnActivate = DXTimerActivate
    OnDeactivate = DXTimerDeactivate
    OnTimer = DXTimerTimer
    Left = 64
    Top = 24
  end
end
