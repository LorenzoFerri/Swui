import UWP

extension Color {
    init(_ argb: Int) {
        self.init(
            a: UInt8((argb >> 24) & 0xFF),
            r: UInt8((argb >> 16) & 0xFF),
            g: UInt8((argb >> 8) & 0xFF),
            b: UInt8(argb & 0xFF)
        )
    }

    static var aliceBlue: Self { return .init(0xFFF0_F8FF) }

    static var antiqueWhite: Self { return .init(0xFFFA_EBD7) }

    static var aqua: Self { return .init(0xFF00_FFFF) }

    static var aquamarine: Self { return .init(0xFF7F_FFD4) }

    static var azure: Self { return .init(0xFFF0_FFFF) }

    static var beige: Self { return .init(0xFFF5_F5DC) }

    static var bisque: Self { return .init(0xFFFF_E4C4) }

    static var black: Self { return .init(0xFF00_0000) }

    static var blanchedAlmond: Self { return .init(0xFFFF_EBCD) }

    static var blue: Self { return .init(0xFF00_00FF) }

    static var blueViolet: Self { return .init(0xFF8A_2BE2) }

    static var brown: Self { return .init(0xFFA5_2A2A) }

    static var burlyWood: Self { return .init(0xFFDE_B887) }

    static var cadetBlue: Self { return .init(0xFF5F_9EA0) }

    static var chartreuse: Self { return .init(0xFF7F_FF00) }

    static var chocolate: Self { return .init(0xFFD2_691E) }

    static var coral: Self { return .init(0xFFFF_7F50) }

    static var cornflowerBlue: Self { return .init(0xFF64_95ED) }

    static var cornsilk: Self { return .init(0xFFFF_F8DC) }

    static var crimson: Self { return .init(0xFFDC_143C) }

    static var cyan: Self { return .init(0xFF00_FFFF) }

    static var darkBlue: Self { return .init(0xFF00_008B) }

    static var darkCyan: Self { return .init(0xFF00_8B8B) }

    static var darkGoldenrod: Self { return .init(0xFFB8_860B) }

    static var darkGray: Self { return .init(0xFFA9_A9A9) }

    static var darkGreen: Self { return .init(0xFF00_6400) }

    static var darkKhaki: Self { return .init(0xFFBD_B76B) }

    static var darkMagenta: Self { return .init(0xFF8B_008B) }

    static var darkOliveGreen: Self { return .init(0xFF55_6B2F) }

    static var darkOrange: Self { return .init(0xFFFF_8C00) }

    static var darkOrchid: Self { return .init(0xFF99_32CC) }

    static var darkRed: Self { return .init(0xFF8B_0000) }

    static var darkSalmon: Self { return .init(0xFFE9_967A) }

    static var darkSeaGreen: Self { return .init(0xFF8F_BC8F) }

    static var darkSlateBlue: Self { return .init(0xFF48_3D8B) }

    static var darkSlateGray: Self { return .init(0xFF2F_4F4F) }

    static var darkTurquoise: Self { return .init(0xFF00_CED1) }

    static var darkViolet: Self { return .init(0xFF94_00D3) }

    static var deepPink: Self { return .init(0xFFFF_1493) }

    static var deepSkyBlue: Self { return .init(0xFF00_BFFF) }

    static var dimGray: Self { return .init(0xFF69_6969) }

    static var dodgerBlue: Self { return .init(0xFF1E_90FF) }

    static var firebrick: Self { return .init(0xFFB2_2222) }

    static var floralWhite: Self { return .init(0xFFFF_FAF0) }

    static var forestGreen: Self { return .init(0xFF22_8B22) }

    static var fuchsia: Self { return .init(0xFFFF_00FF) }

    static var gainsboro: Self { return .init(0xFFDC_DCDC) }

    static var ghostWhite: Self { return .init(0xFFF8_F8FF) }

    static var gold: Self { return .init(0xFFFF_D700) }

    static var goldenrod: Self { return .init(0xFFDA_A520) }

    static var gray: Self { return .init(0xFF80_8080) }

    static var green: Self { return .init(0xFF00_8000) }

    static var greenYellow: Self { return .init(0xFFAD_FF2F) }

    static var honeydew: Self { return .init(0xFFF0_FFF0) }

    static var hotPink: Self { return .init(0xFFFF_69B4) }

    static var indianRed: Self { return .init(0xFFCD_5C5C) }

    static var indigo: Self { return .init(0xFF4B_0082) }

    static var ivory: Self { return .init(0xFFFF_FFF0) }

    static var khaki: Self { return .init(0xFFF0_E68C) }

    static var lavender: Self { return .init(0xFFE6_E6FA) }

    static var lavenderBlush: Self { return .init(0xFFFF_F0F5) }

    static var lawnGreen: Self { return .init(0xFF7C_FC00) }

    static var lemonChiffon: Self { return .init(0xFFFF_FACD) }

    static var lightBlue: Self { return .init(0xFFAD_D8E6) }

    static var lightCoral: Self { return .init(0xFFF0_8080) }

    static var lightCyan: Self { return .init(0xFFE0_FFFF) }

    static var lightGoldenrodYellow: Self { return .init(0xFFFA_FAD2) }

    static var lightGray: Self { return .init(0xFFD3_D3D3) }

    static var lightGreen: Self { return .init(0xFF90_EE90) }

    static var lightPink: Self { return .init(0xFFFF_B6C1) }

    static var lightSalmon: Self { return .init(0xFFFF_A07A) }

    static var lightSeaGreen: Self { return .init(0xFF20_B2AA) }

    static var lightSkyBlue: Self { return .init(0xFF87_CEFA) }

    static var lightSlateGray: Self { return .init(0xFF77_8899) }

    static var lightSteelBlue: Self { return .init(0xFFB0_C4DE) }

    static var lightYellow: Self { return .init(0xFFFF_FFE0) }

    static var lime: Self { return .init(0xFF00_FF00) }

    static var limeGreen: Self { return .init(0xFF32_CD32) }

    static var linen: Self { return .init(0xFFFA_F0E6) }

    static var magenta: Self { return .init(0xFFFF_00FF) }

    static var maroon: Self { return .init(0xFF80_0000) }

    static var mediumAquamarine: Self { return .init(0xFF66_CDAA) }

    static var mediumBlue: Self { return .init(0xFF00_00CD) }

    static var mediumOrchid: Self { return .init(0xFFBA_55D3) }

    static var mediumPurple: Self { return .init(0xFF93_70DB) }

    static var mediumSeaGreen: Self { return .init(0xFF3C_B371) }

    static var mediumSlateBlue: Self { return .init(0xFF7B_68EE) }

    static var mediumSpringGreen: Self { return .init(0xFF00_FA9A) }

    static var mediumTurquoise: Self { return .init(0xFF48_D1CC) }

    static var mediumVioletRed: Self { return .init(0xFFC7_1585) }

    static var midnightBlue: Self { return .init(0xFF19_1970) }

    static var mintCream: Self { return .init(0xFFF5_FFFA) }

    static var mistyRose: Self { return .init(0xFFFF_E4E1) }

    static var moccasin: Self { return .init(0xFFFF_E4B5) }

    static var navajoWhite: Self { return .init(0xFFFF_DEAD) }

    static var navy: Self { return .init(0xFF00_0080) }

    static var oldLace: Self { return .init(0xFFFD_F5E6) }

    static var olive: Self { return .init(0xFF80_8000) }

    static var oliveDrab: Self { return .init(0xFF6B_8E23) }

    static var orange: Self { return .init(0xFFFF_A500) }

    static var orangeRed: Self { return .init(0xFFFF_4500) }

    static var orchid: Self { return .init(0xFFDA_70D6) }

    static var paleGoldenrod: Self { return .init(0xFFEE_E8AA) }

    static var paleGreen: Self { return .init(0xFF98_FB98) }

    static var paleTurquoise: Self { return .init(0xFFAF_EEEE) }

    static var paleVioletRed: Self { return .init(0xFFDB_7093) }

    static var papayaWhip: Self { return .init(0xFFFF_EFD5) }

    static var peachPuff: Self { return .init(0xFFFF_DAB9) }

    static var peru: Self { return .init(0xFFCD_853F) }

    static var pink: Self { return .init(0xFFFF_C0CB) }

    static var plum: Self { return .init(0xFFDD_A0DD) }

    static var powderBlue: Self { return .init(0xFFB0_E0E6) }

    static var purple: Self { return .init(0xFF80_0080) }

    static var red: Self { return .init(0xFFFF_0000) }

    static var rosyBrown: Self { return .init(0xFFBC_8F8F) }

    static var royalBlue: Self { return .init(0xFF41_69E1) }

    static var saddleBrown: Self { return .init(0xFF8B_4513) }

    static var salmon: Self { return .init(0xFFFA_8072) }

    static var sandyBrown: Self { return .init(0xFFF4_A460) }

    static var seaGreen: Self { return .init(0xFF2E_8B57) }

    static var seaShell: Self { return .init(0xFFFF_F5EE) }

    static var sienna: Self { return .init(0xFFA0_522D) }

    static var silver: Self { return .init(0xFFC0_C0C0) }

    static var skyBlue: Self { return .init(0xFF87_CEEB) }

    static var slateBlue: Self { return .init(0xFF6A_5ACD) }

    static var slateGray: Self { return .init(0xFF70_8090) }

    static var snow: Self { return .init(0xFFFF_FAFA) }

    static var springGreen: Self { return .init(0xFF00_FF7F) }

    static var steelBlue: Self { return .init(0xFF46_82B4) }

    static var tan: Self { return .init(0xFFD2_B48C) }

    static var teal: Self { return .init(0xFF00_8080) }

    static var thistle: Self { return .init(0xFFD8_BFD8) }

    static var tomato: Self { return .init(0xFFFF_6347) }

    static var transparent: Self { return .init(0x00FF_FFFF) }

    static var turquoise: Self { return .init(0xFF40_E0D0) }

    static var violet: Self { return .init(0xFFEE_82EE) }

    static var wheat: Self { return .init(0xFFF5_DEB3) }

    static var white: Self { return .init(0xFFFF_FFFF) }

    static var whiteSmoke: Self { return .init(0xFFF5_F5F5) }

    static var yellow: Self { return .init(0xFFFF_FF00) }

    static var yellowGreen: Self { return .init(0xFF9A_CD32) }
}
