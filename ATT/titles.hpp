#define SL_TEXTURES       0x10

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

#define COLOR_BROWN { 0.30, 0.25, 0.2, 0.75 }
#define COLOR_GREEN { 0.2, 0.23, 0.18, 0.75 }
#define COLOR_GREEN_ALPHA { 0.2, 0.23, 0.18, 0.4 }
#define COLOR_GREEN_NOALPHA { 0.2, 0.23, 0.18, 1 }
#define COLOR_LIGHTGREEN { 0.4, 0.55, 0.36, 0.4 }
#define COLOR_LIGHTGRAY { 0.6, 0.6, 0.6, 0.8 }
#define COLOR_LIGHTGRAY_ALPHA { 0.6, 0.6, 0.6, 0.55 }
#define COLOR_WHITE { 1, 1, 1, 1 }
#define COLOR_NOALPHA { 0, 0, 0, 0 }
#define COLOR_BLUFOR { 0, 0.3, 1, 1 }
#define COLOR_OPFOR { 1, 0, 0, 1 }
#define COLOR_GUER { 0.5, 0.5, 0.5, 0.5 }
#define COLOR_WHITE_TRANSP { 1, 1, 1, 0.5 }
#define COLOR_BLACK { 0, 0, 0, 1 }
#define COLOR_BLACK_ALPHA { 0, 0, 0, 0.85 }
#define COLOR_BLUFOR_NOALPHA { 0, 0, 1, 1 }
#define COLOR_OPFOR_NOALPHA { 1, 0, 0, 1 }
#define COLOR_RED_DISABLED { 1,0,0,0.4 }
#define COLOR_BLEEDOUT { 0.66,0,0,0.8 }
#define COLOR_BRIGHTGREEN { 0.2,1,0.2,1 }
#define COLOR_BLUE {0.2,0.2,1,1}

#define SHADOW_X  0.0008
#define SHADOW_Y 0.0011
#define ICONE_SPACY 0.025

#define BORDERSIZE	0.01

#define MAP_IDC 10023


class paradrop {
    name = "paradrop";
    duration = 4;
    idd = -1;
    movingEnable = true;
    controls[] = {
        OuterBackground,GenericLabel111
    };
    class OuterBackground {
        idc = -1;
        type =  CT_STATIC ;
        style = ST_LEFT;
        colorText[] = COLOR_BLACK;
        colorBackground[] = COLOR_BLACK;
        font = "tt2020base_vn";
        sizeEx = 0.023;
        x = -3; y = -3;
        w = 9;  h = 9;
        text = "";
    };
    class GenericLabel111 {
        idc = -1;
        type =  CT_STATIC ;
        style = ST_CENTER;
        colorText[] = COLOR_WHITE;
        colorBackground[] = COLOR_NOALPHA;
        font = "tt2020base_vn";
        sizeEx = 0.03;
        x = 0; y = 0.75;
        w = 1.0;  h = 0.1;
        text = $STR_PARADROP_IN_PROGRESS;
    };
};