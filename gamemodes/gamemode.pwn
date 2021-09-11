// INCLUDES

#include                                                                        <a_samp>
#include                                                                        <a_zone>
#include                                                                        <dof2>
#include                                                                        <sscanf2>
#include                                                                        <streamer>
#include                                                                        <Pawn.CMD>

#include                                                                        <server/builds>
#include                                                                        <server/vehicles>
#include                                                                        <server/text_labels>
#include                                                                        <server/pickups>
#include                                                                        <server/actors>

// SETS

#define NOME_MAPA                                                               "Street Wars"

#define MINIMO_SENHA                                                            4
#define MAXIMO_SENHA                                                            16


// CORES

#define ROSA                                                        	        0xFF82ABF6
#define PRETO                                                                   0x1C1C1CF6
#define VERMELHO                                                                0xFF0000AA
#define VERDE                                                                   0x00FF00F6
#define AZUL                                                                    0x14A5EBAA
#define ROXO                                                                    0xA020F0FF
#define BEM_CLARO                                                               0xFFB7FFF6
#define VERDE_AMARELADO                                                         0xD8FF12F6
#define BRANCO                                                                  0xFFFFFFF6
#define CINZA                                                                   0xD2D2D2F6
#define VERDE_FOLHA                                                             0x90BC70F6
#define LARANJA                                                                 0xFFA500F6
#define AMARELO                                                                 0xFFFF00FF

#define COR_BALLAS                                                              0x9B30FFFF
#define COR_GROOVE                                                              0x008B00FF
#define COR_TLMC                                                                0x363636FF
#define COR_OUTL                                                                0x1C1C1CFF
#define COR_FA                                                                  0x556B2FFF


// DIALOGS

#define DIALOG_REGISTRO                                                         1
#define DIALOG_LOGIN                                                            2

#define DIALOG_ESCOLHER_ORG                                                     3
#define DIALOG_MUDAR_ORG                                                        4

#define DIALOG_ARMARIO_OPCOES                                                   5
#define DIALOG_ARMARIO_ARMAS                                                    6
#define DIALOG_ARMARIO_ROUPAS_FA                                                7
#define DIALOG_ARMARIO_ROUPAS_BLL                                               8
#define DIALOG_ARMARIO_ROUPAS_GSF                                               9
#define DIALOG_ARMARIO_ROUPAS_TLMC                                              10
#define DIALOG_ARMARIO_ROUPAS_OUTL                                              11

#define DIALOG_VEICULOS                                                         25

#define DIALOG_GPS_SELECAO                                                      40
#define DIALOG_GPS_TERRITORIOS                                                  41
#define DIALOG_GPS_ROUBO                                                        42
#define DIALOG_GPS_ARMAS                                                        43
#define DIALOG_GPS_COMERCIANTES                                                 44

#define DIALOG_MENU                                                             60
#define DIALOG_MENU_CONFIGURACOES                                               61
#define DIALOG_MENU_CONQUISTAS                                                  62
#define DIALOG_MENU_HABILIDADES                                                 63

#define DIALOG_CARNE_FRESCA                                                     80
#define DIALOG_HABILIDADE_ROUBO                                                 85

#define DIALOG_MERCADO_NEGRO                                                    100
#define DIALOG_LOJA_ARMAS                                                       110

#define DIALOG_JOGADOR_INFO                                                     130
#define DIALOG_AJUDA                                                            200
#define DIALOG_AJUDA_STAFF                                                      201
#define DIALOG_COMANDOS_GERAIS                                                  202
#define DIALOG_COMANDOS_VIPS                                                    203
#define DIALOG_COMANDOS_STAFF                                                   204

#define DIALOG_VIP_TAG                                                          300
#define DIALOG_VIP_ACESSORIOS                                                   301
#define DIALOG_VIP_ACESSORIOS_CABECA                                            302
#define DIALOG_VIP_ACESSORIOS_TORSO                                             303

#define DIALOG_TUNAR                                                            350
#define DIALOG_TUNAR_NITRO                                                      351
#define DIALOG_VIP_TUNAR_RODAS                                                  352
#define DIALOG_VIP_TUNAR_HIDRAULICAS                                            353


// ENUMERADORES

enum pDados {
    Logado,
    EstaMorto,
    ErrouSenha,
    CriouVeiculo,
    OrgID,
    Dinheiro,
    Score,
    Eliminacoes,
    Mortes,
    LevelAdmin,

    RoubouGranaLoterica,
    TempoRoubarDenovo,

    DominandoTerritorio,

    DominandoPista,
    TentouDominarPista,
    ProvocouPista,

    DominandoCasarao,
    TentouDominarCasarao,
    ProvocouCasarao,

    DominandoAlojamento,
    TentouDominarAlojamento,
    ProvocouAlojamento,

    DominandoConstrucao,
    TentouDominarConstrucao,
    ProvocouConstrucao,

    DominandoMadereira,
    TentouDominarMadereira,
    ProvocouMadereira,

    GameTextDominar,
    PararGameTextDominar
}

enum cDados {
    CheckpointPista,
    CheckpointCasarao,
    CheckpointAlojamento,
    CheckpointConstrucao,
    CheckpointMadereira,
    CheckpointLoterica,
    CheckpointLojaArmasLS,
    CheckpointAyman
}

// DECLARAÇÕES

new
    CheckpointDados[cDados],
    PlayerDados[MAX_PLAYERS][pDados];

new
    Veiculo;

new
    ObjetoDinamiteLoterica,
    PortaLoterica,
    PortaLotericaExplodida;

new
    Text3D:TagVip;

new 
    Area_Pista,
    Area_Casarao, 
    Area_Alojamento, 
    Area_Construcao, 
    Area_Madereira;

new 
    GangZone_Pista, 
    GangZone_Casarao, 
    GangZone_Alojamento, 
    GangZone_Construcao, 
    GangZone_Madereira;

new 
    AlguemDominandoPista,
    AlguemDominandoCasarao, 
    AlguemDominandoAlojamento, 
    AlguemDominandoConstrucao, 
    AlguemDominandoMadereira;

new 
    TempoGuerraPista,
    TempoGuerraCasarao, 
    TempoGuerraAlojamento, 
    TempoGuerraConstrucao, 
    TempoGuerraMadereira;

// ENTRY

main()
{
	print("\n------------------------------------------------");
	print("\tStreet Wars 2020");
	print("------------------------------------------------\n");
}

// GAMEMODE

public OnGameModeInit()
{
    SetGameModeText("GW - 1.0");
    SendRconCommand("mapname " NOME_MAPA);

    DisableInteriorEnterExits();
    UsePlayerPedAnims();
    EnableStuntBonusForAll(0);

    LoadMap();
    LoadVehicles();
    LoadTextLabels();
    LoadPickups();
    LoadActors();

    SetTimer("AtualizarClimaHorario", 600000, true);
    SetTimer("MensagensAutomaticas", 600000, true);

    // Actors
    // Pickups
    // Objetos
    PortaLoterica = CreateObject(2634, 824.20001, 10.2, 1004.3, 0, 0, 272);

    // Areas
    Area_Pista = CreateDynamicRectangle(1861.519897, -1451.005249, 1976.101440, -1351.822509);
    Area_Casarao = CreateDynamicRectangle(1210.579101, -2080.446044, 1103.595825, -1993.308715);
    Area_Alojamento = CreateDynamicRectangle(807.504882, -1310.112915, 933.617980, -1159.493896);
    SendRconCommand("exit");
    Area_Construcao = CreateDynamicRectangle(-2016.497314, 118.468414, -2136.991943, 309.875579);
    Area_Madereira = CreateDynamicRectangle(-423.198974, -37.516921, -576.721313, -194.507461);

    // Zones
    GangZone_Pista = CreateZone(1861.519897, -1451.005249, 1976.101440, -1351.822509);
    GangZone_Casarao = CreateZone(1210.579101, -2080.446044, 1103.595825, -1993.308715);
    GangZone_Alojamento = CreateZone(807.504882, -1310.112915, 933.617980, -1159.493896);
    GangZone_Construcao = CreateZone(-2016.497314, 118.468414, -2136.991943, 309.875579);
    GangZone_Madereira = CreateZone(-423.198974, -37.516921, -576.721313, -194.507461);

    CreateZoneBorders(GangZone_Pista);
    CreateZoneBorders(GangZone_Casarao);
    CreateZoneBorders(GangZone_Alojamento);
    CreateZoneBorders(GangZone_Construcao);
    CreateZoneBorders(GangZone_Madereira);

    // TextLabels
    TagVip = Create3DTextLabel("VIP", 0xFFFFFFFF, 30.0, 40.0, 50.0, 40.0, 0);

    return 1;
}

public OnGameModeExit()
{
    for(new players = 0; players < MAX_PLAYERS; players++) {
        SalvarConta(players);
    }
	DOF2_Exit();
	return 1;
}

public OnPlayerConnect(playerid)
{
    new str[128];
    if(PlayerDados[playerid][Logado] == 0) {
        TogglePlayerSpectating(playerid, 1);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Os dados de sua conta estao sendo carregados.");
    }

    SetTimerEx("CarregarConta", 1000, false, "i", playerid);
    format(str, sizeof(str), "INFO || {FFFFFF}%s(ID: %d) entrou no servidor.", PlayerNome(playerid), playerid);
    SendClientMessageToAll(ROXO, str);     

    for(new chat = 0; chat < 100; chat++) {
        SendClientMessage(playerid, BRANCO, " ");
    }

    if(!DOF2_FileExists(GetAccount(playerid)))
    {
        new string[148];
        format(string, sizeof(string), "{FFFFFF}Seja bem vindo(a) ao Street Wars, {A020F0}%s{FFFFFF}.\n\n{FFFFFF}Informe uma senha para realizar o registro desta conta.", PlayerNome(playerid));
        ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Registro", string, "Registrar", "Cancelar");
    } else {
        new string[164];
        format(string, sizeof(string), "{FFFFFF}Seja bem vindo(a) novamente ao Street Wars, {A020F0}%s{FFFFFF}.\n\n{FFFFFF}Informe sua senha para realizar o login nesta conta.", PlayerNome(playerid));
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Login", string, "Logar", "Cancelar");
    }
    return 1;
} 

public OnPlayerDisconnect(playerid, reason)
{
    SalvarConta(playerid);

    new Motivo[3][] = 
    {
        "por crash ou falha na conexao.",
        "por vontade propria.",
        "banido ou kickado."
    };

    new str[128];
    format(str, sizeof(str), "INFO || {FFFFFF}%s(ID: %d) saiu do servidor %s", PlayerNome(playerid), playerid, Motivo[reason]);
    SendClientMessageToAll(ROXO, str);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    PlayerDados[playerid][Logado] = 1;
    TogglePlayerSpectating(playerid, 0);

    PreloadAnimationLib(playerid, "BOMBER");

    ShowZoneForPlayer(playerid, GangZone_Pista, CorPista());
    ShowZoneForPlayer(playerid, GangZone_Casarao, CorCasarao());
    ShowZoneForPlayer(playerid, GangZone_Alojamento, CorAlojamento());
    ShowZoneForPlayer(playerid, GangZone_Construcao, CorConstrucao());
    ShowZoneForPlayer(playerid, GangZone_Madereira, CorMadereira());

    SetPlayerMapIcon(playerid, 0, 1884.66064453, -1428.08288574, 10.35937500, 19, BRANCO, MAPICON_GLOBAL); // Pista
    SetPlayerMapIcon(playerid, 1, 1180.85986328, -2036.71289062, 69.00781250, 19, BRANCO, MAPICON_GLOBAL); // Casarao
    SetPlayerMapIcon(playerid, 2, 895.35870361, -1251.42553710, 15.26383495, 19, BRANCO, MAPICON_GLOBAL); // Alojamento
    SetPlayerMapIcon(playerid, 3, -2080.60449218, 208.25245666, 35.31754684, 19, BRANCO, MAPICON_GLOBAL); // Construcao
    SetPlayerMapIcon(playerid, 4, -521.10455322, -102.89633941, 63.29875564, 19, BRANCO, MAPICON_GLOBAL); // Madereira
    SetPlayerMapIcon(playerid, 5, 1631.80700683, -1172.25427246, 24.07812500, 52, BRANCO, MAPICON_GLOBAL); // Loterica
    SetPlayerMapIcon(playerid, 6, 2351.5095, -648.0492, 128.0547, 23, BRANCO, MAPICON_GLOBAL); // Ayman
    SetPlayerMapIcon(playerid, 7, 1368.1648, -1279.7548, 13.5469, 6, BRANCO, MAPICON_GLOBAL); // Loja de Armas LS
    SetPlayerMapIcon(playerid, 8, 2104.568115, -1806.430541, 13.554687, 29, BRANCO, MAPICON_GLOBAL); // Pizzaria LS

    /*AddPlayerClass(103,,273.4295,0,0,0,0,0,0); // Ammunation 1
    AddPlayerClass(103,2556.7842,2064.6228,11.0995,355.0579,0,0,0,0,0,0); // Ammunation 2 - LV
    AddPlayerClass(103,-315.8450,829.8062,14.2422,87.5125,0,0,0,0,0,0); // Ammunation 3 - FC
    AddPlayerClass(103,-2626.7468,208.6877,4.5931,184.1787,0,0,0,0,0,0); // Ammunation SF*/

    if(PlayerDados[playerid][EstaMorto] == 1) {
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        if(PlayerDados[playerid][OrgID] == 0) {
            SetPlayerInterior(playerid, 4);
            SetSpawnInfo(playerid, 1, 104, 309.51242065, 313.84609985, 1003.30468750, 85.76629638, 0, 0, 0, 0, 0, 0);
            SetPlayerColor(playerid, COR_BALLAS);
            SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce morreu e spawnou na base da gangue Ballas.");
        }
        else if(PlayerDados[playerid][OrgID] == 1) {
            SetPlayerInterior(playerid, 3);
            SetSpawnInfo(playerid, 2, 106, 2495.56201171, -1711.61279296, 1014.74218750, 0, 0, 0, 0, 0, 0, 0);
            SetPlayerColor(playerid, COR_GROOVE);
            SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce morreu e spawnou na base da gangue Groove Street Families.");
        }
        else if(PlayerDados[playerid][OrgID] == 2) {
            SetPlayerInterior(playerid, 5);
            SetSpawnInfo(playerid, 3, 247, 313.27108764, 1122.37145996, 1083.88281250, 269.70413208, 0, 0, 0, 0, 0, 0);
            SetPlayerColor(playerid, COR_TLMC);
            SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce morreu e spawnou na base do motoclube The Lost MC.");
        }
        else if(PlayerDados[playerid][OrgID] == 3) { // Outlaws MC
            SetPlayerInterior(playerid, 11);
            SetSpawnInfo(playerid, 0, 248, 508.25613403, -85.80767822, 998.96093750, 12.58032608, 0, 0, 0, 0, 0, 0);
            SetPlayerColor(playerid, COR_OUTL);
            SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce morreu e spawnou na base do motoclube Outlaws MC.");  
        }
        PlayerDados[playerid][EstaMorto] = 0;
        PlayerDados[playerid][OrgID] = 1000;
    }
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(PlayerDados[playerid][Logado] == 0) return 0;
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerCameraPos(playerid, 1360.9883,-879.0327,112.7346);
	SetPlayerCameraLookAt(playerid, 1360.9883,-879.0327,112.7346);
    return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(killerid != INVALID_PLAYER_ID) {
        new string_morto[150], string_matou[150];
        format(string_morto, sizeof(string_morto), "AVISO || {FFFFFF}Voce perdeu {33AA33}$600 {FFFFFF}e 2 scores por morrer para %s(ID: %d).", PlayerNome(killerid), killerid);
        format(string_matou, sizeof(string_matou), "AVISO || {FFFFFF}Voce recebeu {33AA33}$600 {FFFFFF}e 2 scores por matar %s(ID: %d).", PlayerNome(playerid), playerid);
        GivePlayerMoney(playerid, -600);
        GivePlayerMoney(killerid, 600);
        SetPlayerScore(playerid, GetPlayerScore(playerid)-2);
        SetPlayerScore(killerid, GetPlayerScore(killerid)+2);

        SendClientMessage(playerid, LARANJA, string_morto);
        SendClientMessage(playerid, LARANJA, "AVISO || {FFFFFF}Voce morreu. Clique em 'SPAWN' para voltar ao jogo.");
        SendClientMessage(killerid, LARANJA, string_matou);

        if(PlayerDados[playerid][DominandoPista] == 1) {
            PlayerDados[playerid][DominandoPista] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouPista] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoPista = 0;

            ZoneStopFlashForAll(GangZone_Pista);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Pista de Skate.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraPista);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoCasarao] == 1) {
            PlayerDados[playerid][DominandoCasarao] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouCasarao] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoCasarao = 0;

            ZoneStopFlashForAll(GangZone_Casarao);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Casarao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraCasarao);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoAlojamento] == 1) {
            PlayerDados[playerid][DominandoAlojamento] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouAlojamento] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoAlojamento = 0;

            ZoneStopFlashForAll(GangZone_Alojamento);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Alojamento.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraAlojamento);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoConstrucao] == 1) {
            PlayerDados[playerid][DominandoConstrucao] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouConstrucao] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoConstrucao = 0;

            ZoneStopFlashForAll(GangZone_Construcao);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Construcao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraConstrucao);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoMadereira] == 1) {
            PlayerDados[playerid][DominandoMadereira] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouMadereira] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoMadereira = 0;

            ZoneStopFlashForAll(GangZone_Madereira);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Madereira.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraMadereira);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
    } else {
        GivePlayerMoney(playerid, -600);
        SetPlayerScore(playerid, GetPlayerScore(playerid)-2);

        SendClientMessage(playerid, LARANJA, "AVISO || {FFFFFF}Voce perdeu {33AA33}$600 {FFFFFF}e 2 scores por morrer.");
        SendClientMessage(playerid, LARANJA, "AVISO || {FFFFFF}Voce morreu. Clique em 'SPAWN' para voltar ao jogo.");

        if(PlayerDados[playerid][DominandoPista] == 1) {
            PlayerDados[playerid][DominandoPista] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouPista] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoPista = 0;

            ZoneStopFlashForAll(GangZone_Pista);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Pista de Skate.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraPista);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoCasarao] == 1) {
            PlayerDados[playerid][DominandoCasarao] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouCasarao] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoCasarao = 0;

            ZoneStopFlashForAll(GangZone_Casarao);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Casarao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraCasarao);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoAlojamento] == 1) {
            PlayerDados[playerid][DominandoAlojamento] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouAlojamento] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoAlojamento = 0;

            ZoneStopFlashForAll(GangZone_Alojamento);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Alojamento.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraAlojamento);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoConstrucao] == 1) {
            PlayerDados[playerid][DominandoConstrucao] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouConstrucao] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoConstrucao = 0;

            ZoneStopFlashForAll(GangZone_Construcao);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Construcao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraConstrucao);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
        else if(PlayerDados[playerid][DominandoMadereira] == 1) {
            PlayerDados[playerid][DominandoMadereira] = 0;
            PlayerDados[playerid][DominandoTerritorio] = 0;
            PlayerDados[playerid][ProvocouMadereira] = 0;
            PlayerDados[playerid][PararGameTextDominar] = 0;
            AlguemDominandoMadereira = 0;

            ZoneStopFlashForAll(GangZone_Madereira);

            new str[142];
            format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Madereira.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, str);
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce morreu.");
            KillTimer(TempoGuerraMadereira);
            KillTimer(PlayerDados[playerid][GameTextDominar]);
        }
    }
    PlayerDados[playerid][EstaMorto] = 1;
    PlayerDados[playerid][Mortes]++;
    PlayerDados[killerid][Eliminacoes]++;
    return 1;
}

public OnPlayerText(playerid, text[])
{
    new string[512];
    if(PlayerDados[playerid][Logado] == 0) return 0;
    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
        format(string, sizeof(string),"|| %s {FFFFFF}|| %s(%d): %s", GetRoleName(playerid), PlayerNome(playerid), playerid, text);
    } else {
       format(string, sizeof(string),"|| %s {FFFFFF}|| [{%s}VIP{FFFFFF}] %s(%d): %s", GetRoleName(playerid), DOF2_GetString(GetAccount(playerid), "CorVIP"), PlayerNome(playerid), playerid, text);
    }
    
    for(new Players = 0; Players < MAX_PLAYERS; Players++){
        new Float:Posicao[3];
        GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

        if(IsPlayerInRangeOfPoint(Players, 12.0, Posicao[0], Posicao[1], Posicao[2])) {
            SendClientMessage(Players, 0xFFFFFFFF, string);
        }
    }

	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid) {
        case DIALOG_REGISTRO: {
            if(response) {
                new string[256];
                format(string, sizeof(string), "{00FF00}Seja bem vindo(a) ao Street Wars\n\n{FFFFFF}Nickname: {FFFFFF}%s\n{FFFFFF}Status da Conta: {FF0000}Nao registrada\n\n{FFFFFF}Informe uma senha para realizar o registro desta conta.", PlayerNome(playerid));
                
                if(strlen(inputtext) < MINIMO_SENHA) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Registro", string, "Registrar", "Cancelar");
                if(strlen(inputtext) > MAXIMO_SENHA) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Registro", string, "Registrar", "Cancelar");
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Registro", "{FFFFFF}Voce nao informou {FF0000}nenhuma senha{FFFFFF}.\n\n{FFFFFF}Informe uma senha valida para realizar o registro de sua conta.", "Avancar", "Cancelar");

                DOF2_CreateFile(GetAccount(playerid));
                DOF2_SetInt(GetAccount(playerid), "OrgID", 1000);
                DOF2_SetInt(GetAccount(playerid), "Policial", 0);
                DOF2_SetInt(GetAccount(playerid), "Dinheiro", 0);
                DOF2_SetInt(GetAccount(playerid), "Score", 0);
                DOF2_SetInt(GetAccount(playerid), "Dinamites", 0);
                DOF2_SetInt(GetAccount(playerid), "Eliminacoes", 0);
                DOF2_SetInt(GetAccount(playerid), "Mortes", 0);
                DOF2_SetInt(GetAccount(playerid), "DJ", 0);
                DOF2_SetInt(GetAccount(playerid), "LevelAdmin", 0);
                DOF2_SetInt(GetAccount(playerid), "Ausente", 0);
                DOF2_SetString(GetAccount(playerid), "UltimoLogin", "00:00:00 - 00/00/0000");
                DOF2_SetString(GetAccount(playerid), "VIP", "false");
                DOF2_SetString(GetAccount(playerid), "CorVIP", "FFFFFF");
                DOF2_SetInt(GetAccount(playerid), "Day_Expiration", 0);
                DOF2_SetInt(GetAccount(playerid), "Hour_Expiration", 0);
                DOF2_SetInt(GetAccount(playerid), "HabilidadeRoubo", 0);
                DOF2_SetInt(GetAccount(playerid), "ConquistaCarneFresca", 0);
                DOF2_SetInt(GetAccount(playerid), "RecolheuCarneFresca", 0);
                DOF2_SetInt(GetAccount(playerid), "VerInfos", 0);
                DOF2_SetInt(GetAccount(playerid), "TemBandana", 0);
                DOF2_SetInt(GetAccount(playerid), "TemBoomBox", 0);
                DOF2_SetInt(GetAccount(playerid), "EquipouBandana", 0);
                DOF2_SetString(GetAccount(playerid), "Senha", inputtext);
                DOF2_SaveFile();

                ShowPlayerDialog(playerid, DIALOG_ESCOLHER_ORG, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Escolher Org", "{A020F0}0 {FFFFFF}- Gangue: Ballas\n{A020F0}1 {FFFFFF}- Gangue: Groove Street Families\n{A020F0}2 {FFFFFF}- Motoclube: The Lost MC\n{A020F0}3 {FFFFFF}- Motoclube: Outlaws MC", "Selecionar", "Cancelar");
            } else {
                SetTimerEx("Kickar", 1000, false, "i", playerid);
            }
        }
        case DIALOG_LOGIN: {
            if(response) {
                if(!strlen(inputtext)) {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Login", "{FFFFFF}Voce nao informou {FF0000}nenhuma senha{FFFFFF}.\n\n{FFFFFF}Informe a sua senha para realizar o login em sua conta.", "Confirmar", "Cancelar");
                } else {
                    if(!strcmp(inputtext, DOF2_GetString(GetAccount(playerid), "Senha"))) {
                        new string[150];
                        format(string, sizeof(string), "INFO || {FFFFFF}Ola %s, seja bem-vindo de volta. Ultimo login realizado: %s.", PlayerNome(playerid), DOF2_GetString(GetAccount(playerid), "UltimoLogin"));
                        SendClientMessage(playerid, VERDE, string);
                        if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) {
                            SetPlayerInterior(playerid, 6);
                            SetSpawnInfo(playerid, 0, 287, 246.292938, 83.994674, 1003.640625, 0, 0, 0, 0, 0, 0, 0);
                            SpawnPlayer(playerid);
                            SetPlayerColor(playerid, COR_FA);
                            SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce logou com sucesso. Voce e das Forcas Armadas.");
                        } else {
                            if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 0) {
                                SetPlayerInterior(playerid, 4);
                                SetSpawnInfo(playerid, 0, 104, 309.51242065, 313.84609985, 1003.30468750, 85.76629638, 0, 0, 0, 0, 0, 0);
                                SpawnPlayer(playerid);
                                SetPlayerColor(playerid, COR_BALLAS);
                                SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce logou com sucesso. Voce e da gangue Ballas.");
                            }
                            else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 1) {
                                SetPlayerInterior(playerid, 3);
                                SetSpawnInfo(playerid, 0, 106, 2495.56201171, -1711.61279296, 1014.74218750, 0, 0, 0, 0, 0, 0, 0);
                                SpawnPlayer(playerid);
                                SetPlayerColor(playerid, COR_GROOVE);
                                SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce logou com sucesso. Voce e da gangue Groove Street Families.");
                            }
                            else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 2) {
                                SetPlayerInterior(playerid, 5);
                                SetSpawnInfo(playerid, 0, 247, 313.27108764, 1122.37145996, 1083.88281250, 269.70413208, 0, 0, 0, 0, 0, 0);
                                SpawnPlayer(playerid);
                                SetPlayerColor(playerid, COR_TLMC);
                                SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce logou com sucesso. Voce e do motoclube The Lost MC.");
                            }
                            else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 3) {
                                SetPlayerInterior(playerid, 11);
                                SetSpawnInfo(playerid, 0, 248, 508.25613403, -85.80767822, 998.96093750, 12.58032608, 0, 0, 0, 0, 0, 0);
                                SpawnPlayer(playerid);
                                SetPlayerColor(playerid, COR_OUTL);
                                SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce logou com sucesso. Voce e do motoclube Outlaws MC.");
                            }
                        }
                    } else {
                        if(PlayerDados[playerid][ErrouSenha] == 3) {
                            SetTimerEx("Kickar", 1000, false, "i", playerid);
                        } else {
                            PlayerDados[playerid][ErrouSenha]++;
                            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "{FFFFFF}Street Wars - Login", "{FFFFFF}Voce informou uma senha {FF0000}incorreta{FFFFFF}.\n\n{FFFFFF}Informe a senha correta para realizar o login em sua conta.", "Confirmar", "Cancelar");
                        }
                    }
                }
            } else {
                SetTimerEx("Kickar", 1000, false, "i", playerid);
            }
        }
        case DIALOG_ESCOLHER_ORG: {
            if(response) {
                TogglePlayerSpectating(playerid, true);
                if(listitem == 0) {
                    SetPlayerInterior(playerid, 4);
                    SetSpawnInfo(playerid, 0, 104, 309.51242065, 313.84609985, 1003.30468750, 85.76629638, 0, 0, 0, 0, 0, 0);
                    SpawnPlayer(playerid);
                    SetPlayerColor(playerid, COR_BALLAS);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a gangue Ballas.");
                    SetTimerEx("Conquista_CarneFresca", 2000, false, "i", playerid);

                    DOF2_SetInt(GetAccount(playerid), "OrgID", 0);
                    DOF2_SaveFile();
                }
                else if(listitem == 1) {
                    SetPlayerInterior(playerid, 3);
                    SetSpawnInfo(playerid, 0, 106, 2495.56201171, -1711.61279296, 1014.74218750, 0, 0, 0, 0, 0, 0, 0);
                    SpawnPlayer(playerid);
                    SetPlayerColor(playerid, COR_GROOVE);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a gangue Groove Street Families.");
                    SetTimerEx("Conquista_CarneFresca", 2000, false, "i", playerid);

                    DOF2_SetInt(GetAccount(playerid), "OrgID", 1);
                    DOF2_SaveFile();
                }
                else if(listitem == 2) {
                    SetPlayerInterior(playerid, 5);
                    SetSpawnInfo(playerid, 0, 247, 313.27108764, 1122.37145996, 1083.88281250, 269.70413208, 0, 0, 0, 0, 0, 0);
                    SpawnPlayer(playerid);
                    SetPlayerColor(playerid, COR_TLMC);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou o motoclube The Lost MC.");
                    SetTimerEx("Conquista_CarneFresca", 2000, false, "i", playerid);

                    DOF2_SetInt(GetAccount(playerid), "OrgID", 2);
                    DOF2_SaveFile();
                }
                else if(listitem == 3) {
                    SetPlayerInterior(playerid, 11);
                    SetSpawnInfo(playerid, 0, 248, 508.25613403, -85.80767822, 998.96093750, 12.58032608, 0, 0, 0, 0, 0, 0);
                    SpawnPlayer(playerid);
                    SetPlayerColor(playerid, COR_OUTL);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou o motoclube Outlaws MC.");
                    SetTimerEx("Conquista_CarneFresca", 2000, false, "i", playerid);

                    DOF2_SetInt(GetAccount(playerid), "OrgID", 3);
                    DOF2_SaveFile();
                }
            } else {
                DOF2_RemoveFile(GetAccount(playerid));
                SetTimerEx("Kickar", 1000, false, "i", playerid);
            }
        }
        case DIALOG_MUDAR_ORG: {
            if(response) {
                if(listitem == DOF2_GetInt(GetAccount(playerid), "OrgID")){
                    SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta nesta organizacao.");
                } else {
                    DOF2_SetInt(GetAccount(playerid), "OrgID", listitem);
                    DOF2_SaveFile();
                    GivePlayerMoney(playerid, -1500);
                    if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 0){
                        SetPlayerInterior(playerid, 4);
                        SetSpawnInfo(playerid, 1, 104, 309.51242065, 313.84609985, 1003.30468750, 85.76629638, 0, 0, 0, 0, 0, 0);
                        SpawnPlayer(playerid);
                        SetPlayerColor(playerid, COR_BALLAS);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce mudou para a gangue Ballas e pagou {33AA33}$1500{FFFFFF}.");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 1){
                        SetPlayerInterior(playerid, 3);
                        SetSpawnInfo(playerid, 2, 106, 2495.56201171, -1711.61279296, 1014.74218750, 0, 0, 0, 0, 0, 0, 0);
                        SpawnPlayer(playerid);
                        SetPlayerColor(playerid, COR_GROOVE);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce mudou para a gangue Groove Street Families e pagou {33AA33}$1500{FFFFFF}.");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 2){
                        SetPlayerInterior(playerid, 5);
                        SetSpawnInfo(playerid, 3, 247, 313.27108764, 1122.37145996, 1083.88281250, 269.70413208, 0, 0, 0, 0, 0, 0);
                        SpawnPlayer(playerid);
                        SetPlayerColor(playerid, COR_TLMC);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce mudou para o motoclube The Lost MC e pagou {33AA33}$1500{FFFFFF}.");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 3){ // Outlaws MC
                        SetPlayerInterior(playerid, 11);
                        SetSpawnInfo(playerid, 0, 248, 508.25613403, -85.80767822, 998.96093750, 12.58032608, 0, 0, 0, 0, 0, 0);
                        SpawnPlayer(playerid);
                        SetPlayerColor(playerid, COR_OUTL);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce mudou para o motoclube Outlaws MC e pagou {33AA33}$1500{FFFFFF}.");  
                    } 
                }
            }
        }
        case DIALOG_ARMARIO_OPCOES: {
            if(response) {
                if(listitem == 0) {
                    ShowPlayerDialog(playerid, DIALOG_ARMARIO_ARMAS, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armas", "{A020F0}0 {FFFFFF}- AK-47\n{A020F0}1 {FFFFFF}- Desert Eagle\n{A020F0}2 - {FFFFFF}MP5", "Selecionar", "Cancelar");
                }
                else if(listitem == 1) {
                    if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) {
                        ShowPlayerDialog(playerid, DIALOG_ARMARIO_ROUPAS_FA, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Roupas", "{A020F0}0 {FFFFFF}- Traje 1 (287)\n{A020F0}1 {FFFFFF}- Traje 2 (191)", "Selecionar", "Cancelar");
                    } else {
                        if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 0) {
                            ShowPlayerDialog(playerid, DIALOG_ARMARIO_ROUPAS_BLL, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Roupas", "{A020F0}0 {FFFFFF}- Traje 1 (102)\n{A020F0}1 {FFFFFF}- Traje 2 (103)\n{A020F0}2 {FFFFFF}- Traje 3 (104)", "Selecionar", "Cancelar");
                        }
                        if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 1) {
                            ShowPlayerDialog(playerid, DIALOG_ARMARIO_ROUPAS_GSF, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Roupas", "{A020F0}0 {FFFFFF}- Traje 1 (105)\n{A020F0}1 {FFFFFF}- Traje 2 (106)\n{A020F0}2 {FFFFFF}- Traje 3 (107)", "Selecionar", "Cancelar");
                        }
                        if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 2) {
                            ShowPlayerDialog(playerid, DIALOG_ARMARIO_ROUPAS_TLMC, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Roupas", "{A020F0}0 {FFFFFF}- Traje 1 (100)\n{A020F0}1 {FFFFFF}- Traje 2 (247)\n{A020F0}2 {FFFFFF}- Traje 3 (248)", "Selecionar", "Cancelar");
                        }
                        if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 3) {
                            ShowPlayerDialog(playerid, DIALOG_ARMARIO_ROUPAS_OUTL, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Roupas", "{A020F0}0 {FFFFFF}- Traje 1 (248)\n{A020F0}1 {FFFFFF}- Traje 2 (181)", "Selecionar", "Cancelar");
                        }
                    }
                }
                else if(listitem == 2) {
                    new Float:Colete;
                    GetPlayerArmour(playerid, Colete);

                    if(Colete > 75.0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}A durabilidade do seu colete esta acima de 75 e voce nao podera pegar outro.");
                    SetPlayerArmour(playerid, 100.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce equipou um colete.");
                }
            }
        }
        case DIALOG_ARMARIO_ARMAS: {
            if(response) {
                new weapons[13][2], str[128];
                for (new i = 0; i <= 12; i++){
                    GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
                }
                if(listitem == 0){
                    if(weapons[5][1] > 500 || weapons[5][1] == 500) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja possui o maximo de municoes dessa arma.");
                    GivePlayerWeapon(playerid, 30, GetNumberTo(weapons[5][1], 500));
                    format(str, sizeof(str), "INFO || {FFFFFF}Voce equipou uma AK-47 com %d municoes.", GetNumberTo(weapons[5][1], 500));
                    SendClientMessage(playerid, VERDE, str);
                }
                else if(listitem == 1){
                    if(weapons[2][1] > 100 || weapons[2][1] == 100) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja possui o maximo de municoes dessa arma.");
                    GivePlayerWeapon(playerid, 24, GetNumberTo(weapons[2][1], 100));
                    format(str, sizeof(str), "INFO || {FFFFFF}Voce equipou uma Desert Eagle com %d municoes.", GetNumberTo(weapons[2][1], 100));
                    SendClientMessage(playerid, VERDE, str);
                }
                else if(listitem == 2){
                    if(weapons[4][1] > 250 || weapons[4][1] == 250) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja possui o maximo de municoes dessa arma.");
                    GivePlayerWeapon(playerid, 29, GetNumberTo(weapons[4][1], 250));
                    format(str, sizeof(str), "INFO || {FFFFFF}Voce equipou uma MP5 com %d municoes.", GetNumberTo(weapons[4][1], 250));
                    SendClientMessage(playerid, VERDE, str);
                }
            }
        }
        case DIALOG_ARMARIO_ROUPAS_FA: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerSkin(playerid, 287);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 287.");
                }
                else if(listitem == 1) {
                    SetPlayerSkin(playerid, 191);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 191.");
                }
            }
        }
        case DIALOG_ARMARIO_ROUPAS_BLL: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerSkin(playerid, 102);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 102.");
                }
                else if(listitem == 1) {
                    SetPlayerSkin(playerid, 103);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 103.");
                }
                else if(listitem == 2) {
                    SetPlayerSkin(playerid, 104);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 104.");
                }
            }
        }
        case DIALOG_ARMARIO_ROUPAS_GSF: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerSkin(playerid, 105);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 105.");
                }
                else if(listitem == 1) {
                    SetPlayerSkin(playerid, 106);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 106.");
                }
                else if(listitem == 2) {
                    SetPlayerSkin(playerid, 107);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 107.");
                }
            }
        }
        case DIALOG_ARMARIO_ROUPAS_TLMC: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerSkin(playerid, 100);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 100.");
                }
                else if(listitem == 1) {
                    SetPlayerSkin(playerid, 247);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 247.");
                }
                else if(listitem == 2) {
                    SetPlayerSkin(playerid, 248);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 248.");
                }
            }
        }
        case DIALOG_ARMARIO_ROUPAS_OUTL: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerSkin(playerid, 248);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 248.");
                }
                else if(listitem == 1) {
                    SetPlayerSkin(playerid, 181);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce selecionou a skin 181.");
                }
            }
        }
        case DIALOG_VEICULOS: {
            if(response) {
                new Float:posicao[3], Float:angulo;

                GetPlayerPos(playerid, posicao[0], posicao[1], posicao[2]);
                GetPlayerFacingAngle(playerid, angulo);

                if(listitem == 0) {
                    Veiculo = CreateVehicle(462, posicao[0], posicao[1], posicao[2], angulo, 1, 1, -1, 0);
                    PutPlayerInVehicle(playerid, Veiculo, 0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Veiculo criado com sucesso.");
                    PlayerDados[playerid][CriouVeiculo] = 1;
                }
                else if(listitem == 1) {
                    Veiculo = CreateVehicle(400, posicao[0], posicao[1], posicao[2], angulo, 1, 1, -1, 0);
                    PutPlayerInVehicle(playerid, Veiculo, 0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Veiculo criado com sucesso.");
                    PlayerDados[playerid][CriouVeiculo] = 1;
                }
            }
        }
        case DIALOG_GPS_SELECAO: {
            if(response) {
                if(listitem == 0){
                    new string[512];
                    new Float:DistanciaPista = GetPlayerDistanceFromPoint(playerid, 1884.66064453, -1428.08288574, 10.35937500);
                    new Float:DistanciaCasarao = GetPlayerDistanceFromPoint(playerid, 1180.85986328, -2036.71289062, 69.00781250);
                    new Float:DistanciaAlojamento = GetPlayerDistanceFromPoint(playerid, 895.35870361, -1251.42553710, 15.26383495);
                    new Float:DistanciaConstrucao = GetPlayerDistanceFromPoint(playerid, -2080.60449218, 208.25245666, 35.31754684);
                    new Float:DistanciaMadereira = GetPlayerDistanceFromPoint(playerid, -521.10455322, -102.89633941, 63.29875564);

                    format(string, sizeof(string), "Local\tMetros\n\
                    {A020F0}0 {FFFFFF}- Pista de Skate\t{A020F0}%0.2fm\n{A020F0}1 {FFFFFF}- Casarao\t{A020F0}%0.2fm\n{A020F0}2 {FFFFFF}- Alojamento\t{A020F0}%0.2fm\n{A020F0}2 {FFFFFF}- Construcao\t{A020F0}%0.2fm\n{A020F0}2 {FFFFFF}- Madereira\t{A020F0}%0.2fm", DistanciaPista, DistanciaCasarao, DistanciaAlojamento, DistanciaConstrucao, DistanciaMadereira);
                    ShowPlayerDialog(playerid, DIALOG_GPS_TERRITORIOS, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - GPS", string, "Selecionar", "Cancelar");
                }
                if(listitem == 1) {
                    new string[128];
                    new Float:DistanciaLoterica = GetPlayerDistanceFromPoint(playerid, 1631.80700683, -1172.25427246, 24.07812500);
                   
                    format(string, sizeof(string), "Local\tMetros\n\
                    {A020F0}0 {FFFFFF}- Loterica\t{A020F0}%0.2fm", DistanciaLoterica);
                    ShowPlayerDialog(playerid, DIALOG_GPS_ROUBO, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - GPS", string, "Selecionar", "Cancelar");
                }
                if(listitem == 2) {
                    new string[128];
                    new Float:DistanciaLojaArmasLS = GetPlayerDistanceFromPoint(playerid, 1368.1648, -1279.7548, 13.5469);
                   
                    format(string, sizeof(string), "Local\tMetros\n\
                    {A020F0}0 {FFFFFF}- Loja de Armas LS\t{A020F0}%0.2fm", DistanciaLojaArmasLS);
                    ShowPlayerDialog(playerid, DIALOG_GPS_ARMAS, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - GPS", string, "Selecionar", "Cancelar");
                }
                if(listitem == 3) {
                    new string[128];
                    new Float:DistanciaAyman = GetPlayerDistanceFromPoint(playerid, 2351.5095, -648.0492, 128.0547);
                   
                    format(string, sizeof(string), "Local\tMetros\n\
                    {A020F0}0 {FFFFFF}- Ayman\t{A020F0}%0.2fm", DistanciaAyman);
                    ShowPlayerDialog(playerid, DIALOG_GPS_COMERCIANTES, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - GPS", string, "Selecionar", "Cancelar");
                }
            }
        }
        case DIALOG_GPS_TERRITORIOS: {
            if(response) {
                if(listitem == 0) {
                    CheckpointDados[CheckpointPista] = SetPlayerCheckpoint(playerid, 1884.66064453, -1428.08288574, 10.35937500, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}A Pista de Skate foi marcada em seu mapa.");
                }
                if(listitem == 1) {
                    CheckpointDados[CheckpointCasarao] = SetPlayerCheckpoint(playerid, 1180.85986328, -2036.71289062, 69.00781250, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}O Casarao foi marcado em seu mapa.");
                }
                if(listitem == 2) {
                    CheckpointDados[CheckpointAlojamento] = SetPlayerCheckpoint(playerid, 895.35870361, -1251.42553710, 15.26383495, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}O Alojamento foi marcado em seu mapa.");
                }
                if(listitem == 3) {
                    CheckpointDados[CheckpointConstrucao] = SetPlayerCheckpoint(playerid, -2080.60449218, 208.25245666, 35.31754684, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}A Construcao foi marcada em seu mapa.");
                }
                if(listitem == 4) {
                    CheckpointDados[CheckpointMadereira] = SetPlayerCheckpoint(playerid, -521.10455322, -102.89633941, 63.29875564, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}A Madereira foi marcada em seu mapa.");
                }
            }
        }
        case DIALOG_GPS_ROUBO: {
            if(response) {
                if(listitem == 0) {
                    CheckpointDados[CheckpointLoterica] = SetPlayerCheckpoint(playerid, 1631.80700683, -1172.25427246, 24.07812500, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}A Loterica foi marcada em seu mapa.");
                }
            }
        }
        case DIALOG_GPS_ARMAS: {
            if(response) {
                if(listitem == 0) {
                    CheckpointDados[CheckpointLojaArmasLS] = SetPlayerCheckpoint(playerid, 1368.1648, -1279.7548, 13.5469, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}A Loja de Armas LS foi marcada em seu mapa.");
                }
            }
        }
        case DIALOG_GPS_COMERCIANTES: {
            if(response) {
                if(listitem == 0) {
                    CheckpointDados[CheckpointAyman] = SetPlayerCheckpoint(playerid, 2351.5095, -648.0492, 128.0547, 2.0);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}O Ayman foi marcado em seu mapa.");
                }
            }
        }
        case DIALOG_MENU: {
            if(response) {
                if(listitem == 0) {
                    if(DOF2_GetInt(GetAccount(playerid), "VerInfos") == 0) {
                        ShowPlayerDialog(playerid, DIALOG_MENU_CONFIGURACOES, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Menu de Configuracoes",
                        "Config\tStatus\n\
                        /info\t{FF0000}Privado",
                        "Alterar", "Cancelar");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "VerInfos") == 1) {
                        ShowPlayerDialog(playerid, DIALOG_MENU_CONFIGURACOES, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Menu de Configuracoes",
                        "Config\tStatus\n\
                        /info\t{00FF00}Publico",
                        "Alterar", "Cancelar");
                    }                
                }
                else if(listitem == 1) {
                    ShowPlayerDialog(playerid, DIALOG_MENU_CONQUISTAS, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Menu de Conquistas", "{A020F0}0 {FFFFFF}- Carne Fresca", "Exibir", "Cancelar");
                }
                else if(listitem == 2) {
                    ShowPlayerDialog(playerid, DIALOG_MENU_HABILIDADES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Menu de Habilidades", "{A020F0}0 {FFFFFF}- Roubo", "Exibir", "Cancelar");
                }
            }
        }
        case DIALOG_MENU_CONFIGURACOES: {
            if(response) {
                if(listitem == 0) {
                    if(DOF2_GetInt(GetAccount(playerid), "VerInfos") == 0) {
                        DOF2_SetInt(GetAccount(playerid), "VerInfos", 1);
                        DOF2_SaveFile();
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Agora suas informacoes sao {00FF00}publicas {FFFFFF}e todos podem ver (/info).");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "VerInfos") == 1) {
                        DOF2_SetInt(GetAccount(playerid), "VerInfos", 0);
                        DOF2_SaveFile();
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Agora suas informacoes sao {FF0000}privadas {FFFFFF}e apenas voce pode ver (/info).");
                    }
                }
            }
        }
        case DIALOG_MENU_CONQUISTAS: {
            if(response) {
                if(listitem == 0) {
                    if(DOF2_GetInt(GetAccount(playerid), "ConquistaCarneFresca") == 0) {
                        if(DOF2_GetInt(GetAccount(playerid), "RecolheuCarneFresca") == 0) {
                            ShowPlayerDialog(playerid, DIALOG_CARNE_FRESCA, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Conquistas", "{FFFFFF}Carne Fresca\n\n{FFFFFF}Completar o registro e selecionar uma organizacao.\n\n\t{FFFFFF}Status: {FF0000}Nao desbloqueada\n\t{FFFFFF}Resgatada: {FF0000}Nao resgatada\n\n{FFFFFF}Recompensas:\n\n\t{33AA33}$5000 {FFFFFF}em dinheiro\n\t{FFFFFF}10 Scores", "Resgatar", "Pronto");
                        } else {
                            ShowPlayerDialog(playerid, DIALOG_CARNE_FRESCA, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Conquistas", "{FFFFFF}Carne Fresca\n\n{FFFFFF}Completar o registro e selecionar uma organizacao.\n\n\t{FFFFFF}Status: {FF0000}Nao desbloqueada\n\t{FFFFFF}Resgatada: {00FF00}Resgatada.\n\n{FFFFFF}Recompensas:\n\n\t{33AA33}$5000 {FFFFFF}em dinheiro\n\t{FFFFFF}10 Scores", "", "Pronto");
                        }
                    } else {
                        if(DOF2_GetInt(GetAccount(playerid), "RecolheuCarneFresca") == 0) {
                            ShowPlayerDialog(playerid, DIALOG_CARNE_FRESCA, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Conquistas", "{FFFFFF}Carne Fresca\n\n{FFFFFF}Completar o registro e selecionar uma organizacao.\n\n\t{FFFFFF}Status: {00FF00}Desbloqueada\n\t{FFFFFF}Resgatada: {FF0000}Nao resgatada\n\n{FFFFFF}Recompensas:\n\n\t{33AA33}$5000 {FFFFFF}em dinheiro\n\t{FFFFFF}10 Scores", "Resgatar", "Pronto");
                        } else {
                            ShowPlayerDialog(playerid, DIALOG_CARNE_FRESCA, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Conquistas", "{FFFFFF}Carne Fresca\n\n{FFFFFF}Completar o registro e selecionar uma organizacao.\n\n\t{FFFFFF}Status: {00FF00}Desbloqueada\n\t{FFFFFF}Resgatada: {00FF00}Resgatada\n\n{FFFFFF}Recompensas:\n\n\t{33AA33}$5000 {FFFFFF}em dinheiro\n\t{FFFFFF}10 Scores", "", "Pronto");
                        }
                    }
                }
            }
        }
        case DIALOG_MENU_HABILIDADES: {
            if(response) {
                if(listitem == 0) {
                    if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 0) {
                        ShowPlayerDialog(playerid, DIALOG_HABILIDADE_ROUBO, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Habilidades", "{FFFFFF}Roubo\n\n{FFFFFF}Chance de obter mais dinheiro por malote.\n\n\t{FFFFFF}Level: {A020F0}0", "Melhorar", "Cancelar");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 1) {
                        ShowPlayerDialog(playerid, DIALOG_HABILIDADE_ROUBO, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Habilidades", "{FFFFFF}Roubo\n\n{FFFFFF}Chance de obter mais dinheiro por malote.\n\n\t{FFFFFF}Level: {A020F0}1", "Melhorar", "Cancelar");
                    }
                    else if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 2) {
                        ShowPlayerDialog(playerid, DIALOG_HABILIDADE_ROUBO, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Habilidades", "{FFFFFF}Roubo\n\n{FFFFFF}Chance de obter mais dinheiro por malote.\n\n\t{FFFFFF}Level: {A020F0}2 {FFFFFF}(Maximo)", "", "Cancelar");
                    }
                }
            }
        }
        case DIALOG_CARNE_FRESCA: {
            if(response) {
                GivePlayerMoney(playerid, 5000);
                SetPlayerScore(playerid, GetPlayerScore(playerid)+10);
                SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce resgatou os premios da conquista {A020F0}'Carne Fresca'{FFFFFF}, voce recebeu {33AA33}$5000 {FFFFFF}e 10 Scores.");
                DOF2_SetInt(GetAccount(playerid), "RecolheuCarneFresca", 1);
                DOF2_SaveFile();
            }
        }
        case DIALOG_HABILIDADE_ROUBO: {
            if(response) {
                if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 0) {
                    if(GetPlayerScore(playerid) < 12) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui score suficiente ({A020F0}12{FFFFFF}).");
                    SetPlayerScore(playerid, GetPlayerScore(playerid)-12);
                    DOF2_SetInt(GetAccount(playerid), "HabilidadeRoubo", 1);
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce melhorou a sua habilidade {A020F0}'Roubo' {FFFFFF}para o nivel 1.");
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Para isso, foram removidos 12 scores de voce.");
                }
                else if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 1) {
                    if(GetPlayerScore(playerid) < 16) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui score suficiente ({A020F0}16{FFFFFF}).");
                    SetPlayerScore(playerid, GetPlayerScore(playerid)-16);
                    DOF2_SetInt(GetAccount(playerid), "HabilidadeRoubo", 2);
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce melhorou a sua habilidade {A020F0}'Roubo' {FFFFFF}para o nivel 2 (maximo).");
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Para isso, foram removidos 16 scores de voce.");
                }
            }
        }
        case DIALOG_MERCADO_NEGRO: {
            if(response) {
                if(listitem == 0) {
                    if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$6000{FFFFFF}).");
                    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 5) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja possui o maximo de dinamites (5/5).");
                    GivePlayerMoney(playerid, -6000);
                    DarDinamite(playerid);
                    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce comprou 1x Dinamite por {33AA33}$6000{FFFFFF}.");
                }
            }
        }
        case DIALOG_LOJA_ARMAS: {
            if(response) {
                new weaponss[13][2], str[128];
                for (new i = 0; i <= 12; i++) {
                    GetPlayerWeaponData(playerid, i, weaponss[i][0], weaponss[i][1]);
                }
                if(listitem == 0) {
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$1000{FFFFFF}).");
                        if(weaponss[5][1] > 250 || weaponss[5][1] == 250) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 250 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 30, GetNumberTo(weaponss[5][1], 500));
                        GivePlayerMoney(playerid, -1000);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma AK-47 com %d municoes por {33AA33}$1000{FFFFFF}.", GetNumberTo(weaponss[5][1], 500));
                        SendClientMessage(playerid, VERDE, str);
                    } else {
                        if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$500{FFFFFF}).");
                        if(weaponss[5][1] > 250 || weaponss[5][1] == 250) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 250 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 30, GetNumberTo(weaponss[5][1], 500));
                        GivePlayerMoney(playerid, -500);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma AK-47 com %d municoes por {33AA33}$500{FFFFFF}.", GetNumberTo(weaponss[5][1], 500));
                        SendClientMessage(playerid, VERDE, str);
                    }
                }
                if(listitem == 1) {
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        if(GetPlayerMoney(playerid) < 600) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$600{FFFFFF}).");
                        if(weaponss[2][1] > 50 || weaponss[2][1] == 50) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 50 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 24, GetNumberTo(weaponss[2][1], 100));
                        GivePlayerMoney(playerid, -600);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma Desert Eagle com %d municoes por {33AA33}$600{FFFFFF}.", GetNumberTo(weaponss[2][1], 100));
                        SendClientMessage(playerid, VERDE, str);
                    } else {
                        if(GetPlayerMoney(playerid) < 300) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$300{FFFFFF}).");
                        if(weaponss[2][1] > 50 || weaponss[2][1] == 50) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 50 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 24, GetNumberTo(weaponss[2][1], 100));
                        GivePlayerMoney(playerid, -300);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma Desert Eagle com %d municoes por {33AA33}$300{FFFFFF}.", GetNumberTo(weaponss[2][1], 100));
                        SendClientMessage(playerid, VERDE, str);
                    }
                }
                if(listitem == 2) {
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$500{FFFFFF}).");
                        if(weapons[4][1] > 125 || weapons[4][1] == 125) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 125 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 29, GetNumberTo(weapons[4][1], 250));
                        GivePlayerMoney(playerid, -500);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma MP5 com %d municoes por {33AA33}$500{FFFFFF}.", GetNumberTo(weaponss[4][1], 250));
                        SendClientMessage(playerid, VERDE, str);
                    } else {
                        if(GetPlayerMoney(playerid) < 250) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$250{FFFFFF}).");
                        if(weapons[4][1] > 125 || weapons[4][1] == 125) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ainda possui 125 municoes ou mais desta arma. Gaste-as para comprar mais.");
                        GivePlayerWeapon(playerid, 29, GetNumberTo(weapons[4][1], 250));
                        GivePlayerMoney(playerid, -250);
                        format(str, sizeof(str), "INFO || {FFFFFF}Voce renovou uma MP5 com %d municoes por {33AA33}$250{FFFFFF}.", GetNumberTo(weaponss[4][1], 250));
                        SendClientMessage(playerid, VERDE, str);
                    }
                }
            }
        }
        case DIALOG_AJUDA: {
            if(response) {
                if(listitem == 0) {
                    new string[350];
                    strcat(string, "{FFFFFF}Comandos Gerais");
                    strcat(string, "\n\n\t{A020F0}/ajuda: {FFFFFF}Exibe a lista de comandos.\n\t{A020F0}/info [id]: {FFFFFF}Exibe informacoes sobre um jogador.");
                    strcat(string, "\n\t{A020F0}/mudar: {FFFFFF}Muda de organizacao.\n\t{A020F0}/dinamitar: {FFFFFF}Planta uma dinamite.");
                    strcat(string, "\n\t{A020F0}/roubar: {FFFFFF}Rouba dinheiro.");
                    ShowPlayerDialog(playerid, DIALOG_COMANDOS_GERAIS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Ajuda", string, "", "Fechar");
                }
                else if(listitem == 2) {
                    new string[16];
                    strcat(string, "{FFFFFF}Comandos VIP");
                    ShowPlayerDialog(playerid, DIALOG_COMANDOS_VIPS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Ajuda", string, "", "Fechar");
                }
            }
        }
        case DIALOG_AJUDA_STAFF: {
            if(response) {
                if(listitem == 0) {
                    new string[350];
                    strcat(string, "{FFFFFF}Comandos Gerais");
                    strcat(string, "\n\n\t{A020F0}/ajuda: {FFFFFF}Exibe a lista de comandos.\n\t{A020F0}/info [id]: {FFFFFF}Exibe informacoes sobre um jogador.");
                    strcat(string, "\n\t{A020F0}/mudar: {FFFFFF}Muda de organizacao.\n\t{A020F0}/dinamitar: {FFFFFF}Planta uma dinamite.");
                    strcat(string, "\n\t{A020F0}/roubar: {FFFFFF}Rouba dinheiro.");
                    ShowPlayerDialog(playerid, DIALOG_COMANDOS_GERAIS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Ajuda", string, "", "Fechar");
                }
                else if(listitem == 2) {
                    new string[20];
                    strcat(string, "{FFFFFF}Comandos VIP");
                    ShowPlayerDialog(playerid, DIALOG_COMANDOS_VIPS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Ajuda", string, "", "Fechar");
                }
                else if(listitem == 3) {
                    new string[32];
                    strcat(string, "{FFFFFF}Comandos Administrativos");
                    ShowPlayerDialog(playerid, DIALOG_COMANDOS_VIPS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Ajuda", string, "", "Fechar");

                }
            }
        }
        case DIALOG_VIP_TAG: {
            if(response) {
                if(listitem == 0) { // Verde
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "00FF00");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {00FF00}Verde{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
                if(listitem == 1) { // Azul
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "0000FF");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {0000FF}Azul{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
                if(listitem == 2) { // Amarelo
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "FFFF00");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {FFFF00}Amarelo{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
                if(listitem == 3) { // Laranja
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "FF8000");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {FF8000}Laranja{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
                if(listitem == 4) { // Vermelho
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "FF0000");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {FF0000}Vermelho{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
                if(listitem == 5) { // Rosa
                    DOF2_SetString(GetAccount(playerid), "CorVIP", "FE2EF7");
                    DOF2_SaveFile();
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Cor da Tag alterada para {FE2EF7}Rosa{FFFFFF}.");
                    SetTimerEx("AlterarCorTagVip", 1000, false, "i", playerid);
                }
            }
        }
        case DIALOG_VIP_ACESSORIOS: {
            if(response) {
                if(listitem == 0) {
                    ShowPlayerDialog(playerid, DIALOG_VIP_ACESSORIOS_CABECA, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Acessorios VIP", "{A020F0}0 {FFFFFF}- Chapeu Michael J.\n{A020F0}1 {FFFFFF}- Gorro Branco\n{A020F0}2 {FFFFFF}- Bone\n{A020F0}3 {FFFFFF}- Fones de ouvido", "Selecionar", "Cancelar");
                }
                if(listitem == 1) {
                    ShowPlayerDialog(playerid, DIALOG_VIP_ACESSORIOS_TORSO, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Acessorios VIP", "{A020F0}0 {FFFFFF}- Coracao exposto\n{A020F0}1 {FFFFFF}- Fuzil M4\n{A020F0}2 {FFFFFF}- Passaro", "Selecionar", "Cancelar");
                }
            }
        }
        case DIALOG_VIP_ACESSORIOS_CABECA: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerAttachedObject(playerid, 0, 18639, 2, 0.131000, 0.019000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Chapeu Michael J. anexado com sucesso.");
                }
                if(listitem == 1) {
                    SetPlayerAttachedObject(playerid, 0, 19065, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Gorro Branco anexado com sucesso.");      
                }
                if(listitem == 2) {
                    SetPlayerAttachedObject(playerid, 0, 18939, 2, 0.164000, 0.001999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Bone anexado com sucesso.");
                }
                if(listitem == 3) {
                    SetPlayerAttachedObject(playerid, 0, 19424, 2, 0.070999, -0.026000, -0.002000, -85.299987, 1.600005, -99.500000, 0.944001, 0.915000, 0.809999);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Fones de Ouvido anexado com sucesso.");
                }
            }
        }
        case DIALOG_VIP_ACESSORIOS_TORSO: {
            if(response) {
                if(listitem == 0) {
                    SetPlayerAttachedObject(playerid, 1, 1240, 1, 0.15, 0.17, 0.06, 0.0, 90.0, 0.0);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Coracao Exposto anexado com sucesso."); 
                }
                if(listitem == 1) {
                    SetPlayerAttachedObject(playerid, 1, 356, 1, -0.2, -0.15, 0.0, 0.0, 24.0, 0.0);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Fuzil M4 anexado com sucesso."); 
                }
                if(listitem == 2) {
                    SetPlayerAttachedObject(playerid, 1, 19078,4,-0.067000,0.053999,0.018000,-168.400039,-169.800003,-2.800000,1.000000,1.000000,1.000000);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Acessorio Passaro anexado com sucesso.");
                }
            }
        }
        case DIALOG_TUNAR: {
            if(response) {
                if(listitem == 0) {
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        ShowPlayerDialog(playerid, DIALOG_TUNAR_NITRO, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Tunar", 
                        "Nitro\tPreco\n\
                        {FFFFFF}Nitro 5x\t{33AA33}$800\n{FFFFFF}Nitro 10x\t{33AA33}$1600",
                        "Selecionar", "Cancelar");
                    } else {
                        ShowPlayerDialog(playerid, DIALOG_TUNAR_NITRO, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Tunar VIP", 
                        "Nitro\tPreco\n\
                        {FFFFFF}Nitro 5x\t{33AA33}$0\n{FFFFFF}Nitro 10x\t{33AA33}$0",
                        "Selecionar", "Cancelar");
                    }    
                }
                if(listitem == 1) {
                    ShowPlayerDialog(playerid, DIALOG_VIP_TUNAR_HIDRAULICAS, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Tunar VIP", 
                    "Hidraulicas\tPreco\n\
                    {FFFFFF}Adicionar\t{33AA33}$0",
                    "Selecionar", "Cancelar");
                }
                if(listitem == 2) {
                    ShowPlayerDialog(playerid, DIALOG_VIP_TUNAR_RODAS, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Street Wars - Tunar VIP",
                    "Rodas\tPreco\n\
                    {FFFFFF}Offroad\t{33AA33}$0\n{FFFFFF}Dollar\t{33AA33}$0\n{FFFFFF}Classic\t{33AA33}$0\n{FFFFFF}Trance\t{33AA33}$0\n{FFFFFF}Twist\t{33AA33}$0\n{FFFFFF}Cutter\t{33AA33}$0",
                    "Selecionar", "Cancelar");
                }
            }
        }
        case DIALOG_TUNAR_NITRO: {
            if(response) {
                new VeiculoNitro;
                if(listitem == 0) { // Nitro 5x
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        if(GetPlayerMoney(playerid) < 800) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$800{FFFFFF}).");
                        VeiculoNitro = GetPlayerVehicleID(playerid);
                        AddVehicleComponent(VeiculoNitro, 1008);
                        GivePlayerMoney(playerid, -800);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce adicionou Nitro {A020F0}5x {FFFFFF}por {33AA33}$800{FFFFFF}.");
                    } else {
                        VeiculoNitro = GetPlayerVehicleID(playerid);
                        AddVehicleComponent(VeiculoNitro, 1008);
                        SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Nitro {A020F0}5x {FFFFFF}adicionado com sucesso.");
                    }
                }
                if(listitem == 1) { // Nitro 10x
                    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                        if(GetPlayerMoney(playerid) < 1600) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$1600{FFFFFF}).");
                        VeiculoNitro = GetPlayerVehicleID(playerid);
                        AddVehicleComponent(VeiculoNitro, 1010);
                        GivePlayerMoney(playerid, -1600);
                        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce adicionou Nitro {A020F0}10x {FFFFFF}por {33AA33}$1600{FFFFFF}.");
                    } else {
                        VeiculoNitro = GetPlayerVehicleID(playerid);
                        AddVehicleComponent(VeiculoNitro, 1010);
                        SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Nitro {A020F0}10x {FFFFFF}adicionado com sucesso.");
                    }
                }
            }
        }
        case DIALOG_VIP_TUNAR_HIDRAULICAS: {
            if(response) {
                new VeiculoHidraulica;
                if(listitem == 0) {
                    VeiculoHidraulica = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoHidraulica, 1087);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Sistema Hidraulico adicionado com sucesso.");
                }
            }
        }
        case DIALOG_VIP_TUNAR_RODAS: {
            if(response) {
                new VeiculoRodas;
                if(listitem == 0) { // Offroad
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1025);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Offroad adicionada com sucesso.");
                }
                if(listitem == 1) { // Dollar
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1083);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Dollar adicionada com sucesso.");
                }
                if(listitem == 2) { // Classic
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1077);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Classic adicionada com sucesso.");
                }
                if(listitem == 3) { // Trance
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1084);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Trance adicionada com sucesso.");
                }
                if(listitem == 4) { // Twist
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1078);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Twist adicionada com sucesso.");
                }
                if(listitem == 5) { // Cutter
                    VeiculoRodas = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(VeiculoRodas, 1079);
                    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Roda Cutter adicionada com sucesso.");
                }
            }
        }
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    new Float:Colete;
    PlayerDados[issuerid][OrgID] = DOF2_GetInt(GetAccount(issuerid), "OrgID");
    GetPlayerArmour(playerid, Colete);
    if(PlayerDados[issuerid][OrgID] == DOF2_GetInt(GetAccount(playerid), "OrgID")) {
        if(Colete > 1) return SetPlayerArmour(playerid, 25.0);
        if(Colete > 25) return SetPlayerArmour(playerid, 50.0);
        if(Colete > 50) return SetPlayerArmour(playerid, 75.0);
        if(Colete > 75) return SetPlayerArmour(playerid, 100.0);
        SetPlayerHealth(playerid, 100.0);
        SendClientMessage(issuerid, LARANJA, "AVISO || {FFFFFF}Nao ataque seus companheiros de equipe.");
    }
    PlayerDados[issuerid][OrgID] = 1000;
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{   
    SetPlayerInterior(playerid, 0);
    SetPlayerPosFindZ(playerid, fX, fY, fZ);
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1884.66064453, -1428.08288574, 10.35937500)){
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou na Pista de Skate.");
        DisablePlayerCheckpoint(playerid);
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1180.85986328, -2036.71289062, 69.00781250)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou no Casarao.");
        DisablePlayerCheckpoint(playerid);
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 895.35870361, -1251.42553710, 15.26383495)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou no Alojamento.");
        DisablePlayerCheckpoint(playerid);
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0, -2080.60449218, 208.25245666, 35.31754684)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou na Construcao.");
        DisablePlayerCheckpoint(playerid);
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.0, -521.10455322, -102.89633941, 63.29875564)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou na Madereira.");
        DisablePlayerCheckpoint(playerid);
    }

    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1631.80700683, -1172.25427246, 24.07812500)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou na Loterica.");
        DisablePlayerCheckpoint(playerid);
    }
    
    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1368.1648, -1279.7548, 13.5469)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou na Loja de Armas LS.");
        DisablePlayerCheckpoint(playerid);
    }

    else if(IsPlayerInRangeOfPoint(playerid, 2.0, 2351.5095, -648.0492, 128.0547)) {
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce chegou no Ayman.");
        DisablePlayerCheckpoint(playerid);
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_SECONDARY_ATTACK) {
        // Exterior Loterica
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1631.80700683, -1172.25427246, 24.07812500)) {
            SetPlayerInterior(playerid, 3);
            SetPlayerPos(playerid, 834.1140, 7.5438, 1004.1797);
        }
        // Interior Loterica
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 834.1140, 7.5438, 1004.1797)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 1631.80700683, -1172.25427246, 24.07812500);
        }

        // Exterior Pizzaria LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2104.568115, -1806.430541, 13.554687)) {
            SetPlayerInterior(playerid, 5);
            SetPlayerPos(playerid, 372.348846, -133.160736, 1001.492187);
        }
        // Exterior Pizzaria LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 372.348846, -133.160736, 1001.492187)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2104.568115, -1806.430541, 13.554687);
        }

        // Exterior Loja de Armas LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1368.1648, -1279.7548, 13.5469)) {
            SetPlayerInterior(playerid, 1);
            SetPlayerPos(playerid, 285.352416, -41.336860, 1001.515625);
        }
        // Interior Loja de Armas LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 285.352416, -41.336860, 1001.515625)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 1368.1648, -1279.7548, 13.5469);
        }

        // Saida Forcas Armadas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 246.726730, 62.542018, 1003.640625)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 192.733489, 1931.366943, 17.640625);
        }
        
        // Exterior Forcas Armadas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 192.733489, 1931.366943, 17.640625)) {
            if(DOF2_GetInt(GetAccount(playerid), "Policial") != 1) {
                return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            } else {
                SetPlayerInterior(playerid, 6);
                SetPlayerPos(playerid, 246.726730, 62.542018, 1003.640625);
            }
        }

        // Saida Base Ballas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 300.85043334, 300.75317382, 999.14843750)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2043.81689453, -1106.85180664, 24.46660804);
        }
        // Entrada Base Ballas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2043.81689453, -1106.85180664, 24.46660804)) {
            if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") != 0) {
                return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            } else {
                SetPlayerInterior(playerid, 4);
                SetPlayerPos(playerid, 300.85043334, 300.75317382, 999.14843750);
            }
        }

        // Saida Base GSF
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2495.98242187, -1692.08422851, 1014.74218750)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2495.47680664, -1690.51440429, 14.76562500);
        }
        // Entrada Base GSF
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2495.47680664, -1690.51440429, 14.76562500)) {
            if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") != 1) {
                return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            } else {
                SetPlayerInterior(playerid, 3);
                SetPlayerPos(playerid, 2495.98242187, -1692.08422851, 1014.74218750);
            }
        }

        // Saida Base TLMC
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 318.29431152, 1114.48205566, 1083.88281250)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, -69.21263885, -1546.24243164, 3.00430750);
        }
        // Entrada Base TLMC
        if(IsPlayerInRangeOfPoint(playerid, 5.0, -69.21263885, -1546.24243164, 3.00430750)) {
            if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") != 2) {
                return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            } else {
                SetPlayerInterior(playerid, 5);
                SetPlayerPos(playerid, 318.29431152, 1114.48205566, 1083.88281250);
            }
        }

        // Saida Base OUTL
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 501.95877075, -68.15670013, 998.75781250)) {
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 646.77307128, -511.14227294, 16.33593750);
        }
        // Entrada Base OUTL
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 646.77307128, -511.14227294, 16.33593750)) {
            if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") != 3) {
                return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode entrar nesta Base.");
            } else {
                SetPlayerInterior(playerid, 11);
                SetPlayerPos(playerid, 501.95877075, -68.15670013, 998.75781250);
            }
        }
    }
    if(newkeys == KEY_YES) {
        // Mercador LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2351.5095, -648.0492, 128.0547)) {
            ShowPlayerDialog(playerid, DIALOG_MERCADO_NEGRO, DIALOG_STYLE_TABLIST_HEADERS, "Street Wars - Ayman",
            "Item\tPreco\n\
            {FFFFFF}Dinamite\t{33AA33}$6000",
            "Comprar", "Cancelar");
        }

        // Loja de Armas LS
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 296.175262, -37.462314, 1001.515625)) {
            if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
                ShowPlayerDialog(playerid, DIALOG_LOJA_ARMAS, DIALOG_STYLE_TABLIST_HEADERS, "Street Wars - Loja de Armas",
                "Arma\tPreco\n\
                {FFFFFF}AK-47\t{33AA33}$1000\n{FFFFFF}Desert Eagle\t{33AA33}$600\n{FFFFFF}MP5\t{33AA33}$500",
                "Comprar", "Cancelar");
            } else {
                ShowPlayerDialog(playerid, DIALOG_LOJA_ARMAS, DIALOG_STYLE_TABLIST_HEADERS, "Street Wars - Loja de Armas",
                "Arma\tPreco\n\
                {FFFFFF}AK-47\t{33AA33}$500\n{FFFFFF}Desert Eagle\t{33AA33}$300\n{FFFFFF}MP5\t{33AA33}$250",
                "Comprar", "Cancelar");
            }
        }

        // Armario Ballas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 305.71868896, 307.09603881, 999.14843750)) {
            ShowPlayerDialog(playerid, DIALOG_ARMARIO_OPCOES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armario", "{A020F0}0 {FFFFFF}- Menu de Armas\n{A020F0}1 {FFFFFF}- Menu de Roupas\n{A020F0}2 {FFFFFF}- Equipar Colete", "Selecionar", "Cancelar");
        }

        //Armario Groove
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 2498.10839843, -1705.58862304, 1014.74218750)) {
            ShowPlayerDialog(playerid, DIALOG_ARMARIO_OPCOES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armario", "{A020F0}0 {FFFFFF}- Menu de Armas\n{A020F0}1 {FFFFFF}- Menu de Roupas\n{A020F0}2 {FFFFFF}- Equipar Colete", "Selecionar", "Cancelar");
        }  

        // Armario The Lost MC
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 322.04821777, 1116.99633789, 1083.88281250)) {
            ShowPlayerDialog(playerid, DIALOG_ARMARIO_OPCOES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armario", "{A020F0}0 {FFFFFF}- Menu de Armas\n{A020F0}1 {FFFFFF}- Menu de Roupas\n{A020F0}2 {FFFFFF}- Equipar Colete", "Selecionar", "Cancelar");
        }

        // Armario Outlaws MC
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 504.94070434, -76.66397094, 998.75781250)) {
            ShowPlayerDialog(playerid, DIALOG_ARMARIO_OPCOES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armario", "{A020F0}0 {FFFFFF}- Menu de Armas\n{A020F0}1 {FFFFFF}- Menu de Roupas\n{A020F0}2 {FFFFFF}- Equipar Colete", "Selecionar", "Cancelar");
        }

        // Armario Forcas Armadas
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 254.422241, 75.341224, 1003.640625)) {
            ShowPlayerDialog(playerid, DIALOG_ARMARIO_OPCOES, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Armario", "{A020F0}0 {FFFFFF}- Menu de Armas\n{A020F0}1 {FFFFFF}- Menu de Roupas\n{A020F0}2 {FFFFFF}- Equipar Colete", "Selecionar", "Cancelar");
        }
    }
    if(newkeys == KEY_CTRL_BACK) {
        // Pista
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1884.66064453, -1428.08288574, 10.35937500)) {
            PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
            if(DOF2_GetInt(GetAccount(playerid), "LevelDmin") > 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode dominar territorios por ser da equipe Street Wars.");
            if(DOF2_GetInt("Territorios/Pista.ini", "QuemDomina") == PlayerDados[playerid][OrgID]) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este territorio ja esta sob o dominio de sua organizacao.");
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
            if(PlayerDados[playerid][DominandoTerritorio] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta dominando um territorio.");
            if(AlguemDominandoPista == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Alguem ja esta dominando este territorio."); 

            new string[150], str[132];

            PlayerDados[playerid][DominandoPista] = 1;
            PlayerDados[playerid][TentouDominarPista] = 1;
            PlayerDados[playerid][OrgID] = 1000;
            AlguemDominandoPista = 1;

            format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s estao tentando dominar a Pista de Skate.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            format(str, sizeof(str), "INFO || {FFFFFF}Voce e a %s estao tentando dominar a Pista de Skate. Aguarde 30 segundos.", NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, string);
            SendClientMessage(playerid, AZUL, str);

            TempoGuerraPista = SetTimerEx("Guerra_Pista", 30000, 0, "i", playerid);
            PlayerDados[playerid][PararGameTextDominar] = 30;
            PlayerDados[playerid][GameTextDominar] = SetTimerEx("GameText_Dominar", 1000, true, "i", playerid);
            ZoneFlashForAll(GangZone_Pista, GetPlayerColor(playerid));
        }
        // Casarao
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1180.85986328, -2036.71289062, 69.00781250)) {
            PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
            if(DOF2_GetInt(GetAccount(playerid), "LevelDmin") > 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode dominar territorios por ser da equipe Street Wars.");
            if(DOF2_GetInt("Territorios/Casarao.ini", "QuemDomina") == PlayerDados[playerid][OrgID]) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este territorio ja esta sob o dominio de sua organizacao.");
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
            if(PlayerDados[playerid][DominandoTerritorio] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta dominando um territorio.");
            if(AlguemDominandoCasarao == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Alguem ja esta dominando este territorio."); 

            new string[150], str[132];

            PlayerDados[playerid][DominandoCasarao] = 1;
            PlayerDados[playerid][TentouDominarCasarao] = 1;
            PlayerDados[playerid][OrgID] = 1000;
            AlguemDominandoCasarao = 1;

            format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s estao tentando dominar o Casarao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            format(str, sizeof(str), "INFO || {FFFFFF}Voce e a %s estao tentando dominar o Casarao. Aguarde 30 segundos.", NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, string);
            SendClientMessage(playerid, AZUL, str);

            TempoGuerraCasarao = SetTimerEx("Guerra_Casarao", 30000, 0, "i", playerid);
            PlayerDados[playerid][PararGameTextDominar] = 30;
            PlayerDados[playerid][GameTextDominar] = SetTimerEx("GameText_Dominar", 1000, true, "i", playerid);
            ZoneFlashForAll(GangZone_Casarao, GetPlayerColor(playerid));
        }
        // Alojamento
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 895.35870361, -1251.42553710, 15.26383495)) {
            PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
            if(DOF2_GetInt(GetAccount(playerid), "LevelDmin") > 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode dominar territorios por ser da equipe Street Wars.");
            if(DOF2_GetInt("Territorios/Alojamento.ini", "QuemDomina") == PlayerDados[playerid][OrgID]) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este territorio ja esta sob o dominio de sua organizacao.");
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
            if(PlayerDados[playerid][DominandoTerritorio] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta dominando um territorio.");
            if(AlguemDominandoAlojamento == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Alguem ja esta dominando este territorio."); 

            new string[150], str[132];

            PlayerDados[playerid][DominandoAlojamento] = 1;
            PlayerDados[playerid][TentouDominarAlojamento] = 1;
            PlayerDados[playerid][OrgID] = 1000;
            AlguemDominandoAlojamento = 1;

            format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s estao tentando dominar o Alojamento.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            format(str, sizeof(str), "INFO || {FFFFFF}Voce e a %s estao tentando dominar o Alojamento. Aguarde 30 segundos.", NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, string);
            SendClientMessage(playerid, AZUL, str);

            TempoGuerraAlojamento = SetTimerEx("Guerra_Alojamento", 30000, 0, "i", playerid);
            PlayerDados[playerid][PararGameTextDominar] = 30;
            PlayerDados[playerid][GameTextDominar] = SetTimerEx("GameText_Dominar", 1000, true, "i", playerid);
            ZoneFlashForAll(GangZone_Alojamento, GetPlayerColor(playerid));
        }
        // Construcao
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -2080.60449218, 208.25245666, 35.31754684)) {
            PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
            if(DOF2_GetInt(GetAccount(playerid), "LevelDmin") > 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode dominar territorios por ser da equipe Street Wars.");
            if(DOF2_GetInt("Territorios/Construcao.ini", "QuemDomina") == PlayerDados[playerid][OrgID]) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este territorio ja esta sob o dominio de sua organizacao.");
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
            if(PlayerDados[playerid][DominandoTerritorio] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta dominando um territorio.");
            if(AlguemDominandoConstrucao == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Alguem ja esta dominando este territorio."); 

            new string[150], str[132];

            PlayerDados[playerid][DominandoConstrucao] = 1;
            PlayerDados[playerid][TentouDominarConstrucao] = 1;
            PlayerDados[playerid][OrgID] = 1000;
            AlguemDominandoConstrucao = 1;

            format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s estao tentando dominar a Construcao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            format(str, sizeof(str), "INFO || {FFFFFF}Voce e a %s estao tentando dominar a Construcao. Aguarde 30 segundos.", NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, string);
            SendClientMessage(playerid, AZUL, str);

            TempoGuerraAlojamento = SetTimerEx("Guerra_Construcao", 30000, 0, "i", playerid);
            PlayerDados[playerid][PararGameTextDominar] = 30;
            PlayerDados[playerid][GameTextDominar] = SetTimerEx("GameText_Dominar", 1000, true, "i", playerid);
            ZoneFlashForAll(GangZone_Construcao, GetPlayerColor(playerid));
        }
        // Madereira
        if(IsPlayerInRangeOfPoint(playerid, 3.0, -521.10455322, -102.89633941, 63.29875564)) {
            PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
            if(DOF2_GetInt(GetAccount(playerid), "LevelDmin") > 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode dominar territorios por ser da equipe Street Wars.");
            if(DOF2_GetInt("Territorios/Madereira.ini", "QuemDomina") == PlayerDados[playerid][OrgID]) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este territorio ja esta sob o dominio de sua organizacao.");
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
            if(PlayerDados[playerid][DominandoTerritorio] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja esta dominando um territorio.");
            if(AlguemDominandoMadereira == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Alguem ja esta dominando este territorio."); 

            new string[150], str[132];

            PlayerDados[playerid][DominandoMadereira] = 1;
            PlayerDados[playerid][TentouDominarMadereira] = 1;
            PlayerDados[playerid][OrgID] = 1000;
            AlguemDominandoMadereira = 1;

            format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s estao tentando dominar a Madereira.", PlayerNome(playerid), playerid, NomeOrg(playerid));
            format(str, sizeof(str), "INFO || {FFFFFF}Voce e a %s estao tentando dominar a Madereira. Aguarde 30 segundos.", NomeOrg(playerid));
            SendClientMessageToAll(AMARELO, string);
            SendClientMessage(playerid, AZUL, str);

            TempoGuerraAlojamento = SetTimerEx("Guerra_Madereira", 30000, 0, "i", playerid);
            PlayerDados[playerid][PararGameTextDominar] = 30;
            PlayerDados[playerid][GameTextDominar] = SetTimerEx("GameText_Dominar", 1000, true, "i", playerid);
            ZoneFlashForAll(GangZone_Madereira, GetPlayerColor(playerid));
        }
    }
    return 1;
}

public OnRconCommand(cmd[])
{
    if(!strcmp("gmx", cmd)) {
        for(new Players = 0; Players < MAX_PLAYERS; Players++) {
            SendClientMessage(Players, LARANJA, "AVISO || {FFFFFF}Voce foi kickado para escapar do GMX.");
            SetTimerEx("Kickar", 1000, false, "i", Players);
        }
    }
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1) {
        new string[128];
        format(string, sizeof(string), "ERRO || {FFFFFF}O comando {FF0000}(%s) {FFFFFF}que voce digitou nao existe.", cmd);
        SendClientMessage(playerid, VERMELHO, string);
        return 0;
    }

    return 1;
}

// FUNCS

forward AtualizarClimaHorario();
forward MensagensAutomaticas();
forward Kickar(playerid);
forward CarregarConta(playerid);
forward Conquista_CarneFresca(playerid);
forward ExplosaoPortaLoterica(playerid);
forward ExplodirCofreLoterica(playerid);
forward RepararPortaLoterica();
forward TempoRoubarLotericaDenovo(playerid);
forward Guerra_Pista(playerid);
forward Guerra_Casarao(playerid);
forward Guerra_Alojamento(playerid);
forward Guerra_Construcao(playerid);
forward Guerra_Madereira(playerid);
forward GameText_Dominar(playerid);
forward AlterarCorTagVip(playerid);

public AtualizarClimaHorario() {
    new Clima = random(20);
    new Hora = random(23);
    SetWeather(Clima);
    SetWorldTime(Hora);
    return 1;
}

public MensagensAutomaticas() {
    new Mensagens[][] = {
        "INFO || {FFFFFF}Ficou perdido? Deseja saber onde fica algum lugar? Use /gps.",
        "INFO || {FFFFFF}Deseja ajudar o servidor manter-se online? Compre VIP em nosso Site.",
        "INFO || {FFFFFF}Acesse o nosso forum: forum.streetwars.com.br"
    };
    new RandomMensagens = random(sizeof(Mensagens));
    SendClientMessageToAll(ROXO, Mensagens[RandomMensagens]);
}

public Kickar(playerid) {
    Kick(playerid);
    return 1;
}

public CarregarConta(playerid) {
    PlayerDados[playerid][Logado] = 0;
    PlayerDados[playerid][Dinheiro] = DOF2_GetInt(GetAccount(playerid), "Dinheiro");
    PlayerDados[playerid][Score] = DOF2_GetInt(GetAccount(playerid), "Score");
    PlayerDados[playerid][Eliminacoes] = DOF2_GetInt(GetAccount(playerid), "Eliminacoes");
    PlayerDados[playerid][Mortes] = DOF2_GetInt(GetAccount(playerid), "Mortes");
    PlayerDados[playerid][LevelAdmin] = DOF2_GetInt(GetAccount(playerid), "LevelAdmin");

    GivePlayerMoney(playerid, PlayerDados[playerid][Dinheiro]);
    SetPlayerScore(playerid, PlayerDados[playerid][Score]);
    return 1;
}

public Conquista_CarneFresca(playerid) {
    DOF2_SetInt(GetAccount(playerid), "ConquistaCarneFresca", 1);
    DOF2_SaveFile();
    PlayerPlaySound(playerid, 1054, 0, 0, 0);
    SendClientMessage(playerid, ROXO, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    SendClientMessage(playerid, ROXO, "CONQUISTA || {FFFFFF}Voce liberou a conquista {A020F0}'Carne Fresca'{FFFFFF} (/menu).");
    SendClientMessage(playerid, ROXO, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    return 1;
}

public ExplosaoPortaLoterica(playerid) {
    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce plantou uma dinamite no cofre da loterica, ela ira explodir em alguns segundos. Afaste-se bem!");
    ObjetoDinamiteLoterica = CreateObject(1654, 824.72595214, 10.20378112, 1005.00000000, 0, 0, 0);
    
    SetTimerEx("ExplodirCofreLoterica", 10000, false, "i", playerid);
    SetTimer("RepararPortaLoterica", 900000, false);
    return 1;
}

public ExplodirCofreLoterica(playerid) {
    CreateExplosion(824.72595214, 10.20378112, 1004.17968750, 0, 3.0);
    DestroyObject(ObjetoDinamiteLoterica);
    DestroyObject(PortaLoterica);
    PortaLotericaExplodida = 1;

    new string[128];
    format(string, sizeof(string), "INFO || {FFFFFF}%s(ID: %d) conseguiu explodir a porta do cofre da Loterica.", PlayerNome(playerid), playerid);
    SendClientMessageToAll(AZUL, string);
    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce explodiu a porta da Loterica, ela sera automaticamente reparada em alguns minutos.");
    return 1;
}

public RepararPortaLoterica() {
    PortaLoterica = CreateObject(2634, 824.20001, 10.2, 1004.3, 0, 0, 272);
    PortaLotericaExplodida = 0;
    SendClientMessageToAll(AZUL, "INFO || {FFFFFF}A porta da loterica foi reparada automaticamente.");
    return 1;
}

public TempoRoubarLotericaDenovo(playerid) {
    if(PlayerDados[playerid][RoubouGranaLoterica] == 0) {
        KillTimer(PlayerDados[playerid][TempoRoubarDenovo]);
    } else {
        PlayerDados[playerid][RoubouGranaLoterica]--;
    }
    return 1;
}

public Guerra_Pista(playerid) {
    //if(IsPlayerInRangeOfPoint(playerid, 8.0, 1884.66064453, -1428.08288574, 10.35937500)){
    if(IsPlayerInDynamicArea(playerid, Area_Pista)) {
        new string[150];
        ZoneStopFlashForAll(GangZone_Pista);
        ShowZoneForAll(GangZone_Pista, GetPlayerColor(playerid));

        PlayerDados[playerid][DominandoPista] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouPista] = 0;
        AlguemDominandoPista = 0;

        KillTimer(TempoGuerraPista);
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        DOF2_SetInt("Territorios/Pista.ini", "QuemDomina", PlayerDados[playerid][OrgID]);
        DOF2_SaveFile();
        format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s conseguiram dominar a Pista de Skate.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, string);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce recebeu {33AA33}$2000{FFFFFF} por dominar um territorio.");
        GivePlayerMoney(playerid, 2000);
        for(new Player = 0; Player < MAX_PLAYERS; Player++) {
            new string2[148];
            if(IsPlayerInDynamicArea(Player, Area_Pista) && Player != playerid) {
                if(PlayerDados[playerid][OrgID] == DOF2_GetInt(GetAccount(Player), "OrgID")) {
                    GivePlayerMoney(Player, 500);
                    format(string2, sizeof(string2), "INFO || {FFFFFF}Voce recebeu {33AA33}$500{FFFFFF} por participar do dominio de um territorio com a %s.", NomeOrg(Player));
                    SendClientMessage(Player, VERDE, string2);
                }
            }
        }
        PlayerDados[playerid][OrgID] = 1000;
    } else {
        PlayerDados[playerid][DominandoPista] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouPista] = 0;
        AlguemDominandoPista = 0;

        ZoneStopFlashForAll(GangZone_Pista);
        new str[142];
        format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Pista de Skate.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, str);
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce se distanciou muito.");
    }
    return 1;
}

public Guerra_Casarao(playerid) {
    //if(IsPlayerInRangeOfPoint(playerid, 8.0, 1180.85986328, -2036.71289062, 69.00781250)){
    if(IsPlayerInDynamicArea(playerid, Area_Casarao)) {
        new string[150];
        ZoneStopFlashForAll(GangZone_Casarao);
        ShowZoneForAll(GangZone_Casarao, GetPlayerColor(playerid));

        PlayerDados[playerid][DominandoCasarao] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouCasarao] = 0;
        AlguemDominandoCasarao = 0;

        KillTimer(TempoGuerraCasarao);
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        DOF2_SetInt("Territorios/Casarao.ini", "QuemDomina", PlayerDados[playerid][OrgID]);
        DOF2_SaveFile();
        format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s conseguiram dominar o Casarao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, string);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce recebeu {33AA33}$2000{FFFFFF} por dominar um territorio.");
        GivePlayerMoney(playerid, 2000);
        PlayerDados[playerid][OrgID] = 1000;
    } else {
        PlayerDados[playerid][DominandoCasarao] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouCasarao] = 0;
        AlguemDominandoCasarao = 0;

        ZoneStopFlashForAll(GangZone_Casarao);
        new str[142];
        format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Casarao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, str);
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce se distanciou muito.");
    }
    return 1;
}

public Guerra_Alojamento(playerid) {
    //if(IsPlayerInRangeOfPoint(playerid, 8.0, 895.35870361, -1251.42553710, 15.26383495)){
    if(IsPlayerInDynamicArea(playerid, Area_Alojamento)) {
        new string[150];
        ZoneStopFlashForAll(GangZone_Alojamento);
        ShowZoneForAll(GangZone_Alojamento, GetPlayerColor(playerid));

        PlayerDados[playerid][DominandoAlojamento] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouAlojamento] = 0;
        AlguemDominandoAlojamento = 0;

        KillTimer(TempoGuerraAlojamento);
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        DOF2_SetInt("Territorios/Alojamento.ini", "QuemDomina", PlayerDados[playerid][OrgID]);
        DOF2_SaveFile();
        format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s conseguiram dominar o Alojamento.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, string);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce recebeu {33AA33}$2000{FFFFFF} por dominar um territorio.");
        GivePlayerMoney(playerid, 2000);
        PlayerDados[playerid][OrgID] = 1000;
    } else {
        PlayerDados[playerid][DominandoAlojamento] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouAlojamento] = 0;
        AlguemDominandoAlojamento = 0;

        ZoneStopFlashForAll(GangZone_Alojamento);
        new str[142];
        format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar o Alojamento.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, str);
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce se distanciou muito.");
    }
    return 1;
}

public Guerra_Construcao(playerid) {
    //if(IsPlayerInRangeOfPoint(playerid, 8.0, -2080.60449218, 208.25245666, 35.31754684)){
    if(IsPlayerInDynamicArea(playerid, Area_Construcao)) {
        new string[150];
        ZoneStopFlashForAll(GangZone_Construcao);
        ShowZoneForAll(GangZone_Construcao, GetPlayerColor(playerid));

        PlayerDados[playerid][DominandoConstrucao] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouConstrucao] = 0;
        AlguemDominandoAlojamento = 0;

        KillTimer(TempoGuerraConstrucao);
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        DOF2_SetInt("Territorios/Construcao.ini", "QuemDomina", PlayerDados[playerid][OrgID]);
        DOF2_SaveFile();
        format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s conseguiram dominar a Contrucao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, string);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce recebeu {33AA33}$2000{FFFFFF} por dominar um territorio.");
        GivePlayerMoney(playerid, 2000);
        PlayerDados[playerid][OrgID] = 1000;
    } else {
        PlayerDados[playerid][DominandoConstrucao] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouConstrucao] = 0;
        AlguemDominandoConstrucao = 0;

        ZoneStopFlashForAll(GangZone_Construcao);
        new str[142];
        format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Construcao.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, str);
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce se distanciou muito.");
    }
    return 1;
}

public Guerra_Madereira(playerid) {
    //if(IsPlayerInRangeOfPoint(playerid, 8.0, -521.10455322, -102.89633941, 63.29875564)){
    if(IsPlayerInDynamicArea(playerid, Area_Madereira)) {
        new string[150];
        ZoneStopFlashForAll(GangZone_Madereira);
        ShowZoneForAll(GangZone_Madereira, GetPlayerColor(playerid));

        PlayerDados[playerid][DominandoMadereira] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouMadereira] = 0;
        AlguemDominandoMadereira = 0;

        KillTimer(TempoGuerraMadereira);
        PlayerDados[playerid][OrgID] = DOF2_GetInt(GetAccount(playerid), "OrgID");
        DOF2_SetInt("Territorios/Madereira.ini", "QuemDomina", PlayerDados[playerid][OrgID]);
        DOF2_SaveFile();
        format(string, sizeof(string), "NEWS || {FFFFFF}%s(ID: %d) e a %s conseguiram dominar a Madereira.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, string);
        SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Voce recebeu {33AA33}$2000{FFFFFF} por dominar um territorio.");
        GivePlayerMoney(playerid, 2000);
        PlayerDados[playerid][OrgID] = 1000;
    } else {
        PlayerDados[playerid][DominandoMadereira] = 0;
        PlayerDados[playerid][DominandoTerritorio] = 0;
        PlayerDados[playerid][ProvocouMadereira] = 0;
        AlguemDominandoMadereira = 0;

        ZoneStopFlashForAll(GangZone_Madereira);
        new str[142];
        format(str, sizeof(str), "NEWS || {FFFFFF}%s(ID: %d) e a %s nao conseguiram dominar a Madereira.", PlayerNome(playerid), playerid, NomeOrg(playerid));
        SendClientMessageToAll(AMARELO, str);
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}O dominio do territorio foi cancelado. Voce se distanciou muito.");
    }
    return 1;
}

public GameText_Dominar(playerid) {
    if(PlayerDados[playerid][PararGameTextDominar] == 0){
        KillTimer(PlayerDados[playerid][GameTextDominar]);
    } else {
        PlayerDados[playerid][PararGameTextDominar]--;
        new string[20];
        format(string, sizeof string, "~r~%i ~w~Segundos", PlayerDados[playerid][PararGameTextDominar]);
        GameTextForPlayer(playerid, string, 1000, 3);
        PlayerPlaySound(playerid, 1138, 0, 0, 0);
    }
    return 1;
}

public AlterarCorTagVip(playerid) {
    if(!strcmp("00FF00", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Verde
        Update3DTextLabelText(TagVip, 0x00FF00FF, "VIP");
    }
    if(!strcmp("0000FF", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Azul
        Update3DTextLabelText(TagVip, 0x0000FFFF, "VIP");
    }
    if(!strcmp("FFFF00", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Amarelo
        Update3DTextLabelText(TagVip, 0xFFFF00FF, "VIP");
    }
    if(!strcmp("FF8000", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Laranja
        Update3DTextLabelText(TagVip, 0xFF8000FF, "VIP");
    }
    if(!strcmp("FF0000", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Vermelho
        Update3DTextLabelText(TagVip, 0xFF0000FF, "VIP");
    }
    if(!strcmp("FE2EF7", DOF2_GetString(GetAccount(playerid), "CorVIP"))) { // Rosa
        Update3DTextLabelText(TagVip, 0xFE2EF7FF, "VIP");
    }
    return 1;
}

stock GetAccount(playerid) {
	new Arquivo[32], Nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Nome, sizeof(Nome));
	format(Arquivo, sizeof(Arquivo), "Contas/%s.ini", Nome);
	return Arquivo;
}

stock PlayerNome(playerid) {
    new Name[24];
    GetPlayerName(playerid, Name, 24);
    return Name;
}

stock SalvarConta(playerid) {
    TogglePlayerSpectating(playerid, 1);
    new hora[3], data[3], string[24];

    gettime(hora[0], hora[1], hora[2]);
    getdate(data[2], data[1], data[0]);

    format(string, sizeof(string), "%02d:%02d:%02d - %02d/%02d/%04d", hora[0], hora[1], hora[2], data[0], data[1], data[2]);

    DOF2_SetInt(GetAccount(playerid), "Dinheiro", GetPlayerMoney(playerid));
    DOF2_SetInt(GetAccount(playerid), "Score", GetPlayerScore(playerid));
    DOF2_SetInt(GetAccount(playerid), "Eliminacoes", PlayerDados[playerid][Eliminacoes]);
    DOF2_SetInt(GetAccount(playerid), "Mortes", PlayerDados[playerid][Mortes]);
    DOF2_SetInt(GetAccount(playerid), "LevelAdmin", PlayerDados[playerid][LevelAdmin]);
    DOF2_SetString(GetAccount(playerid), "UltimoLogin", string);
    DOF2_SaveFile();

    PlayerDados[playerid][Logado] = 0;
    PlayerDados[playerid][ErrouSenha] = 0;
    PlayerDados[playerid][CriouVeiculo] = 0;
    PlayerDados[playerid][EstaMorto] = 0;

    PlayerDados[playerid][RoubouGranaLoterica] = 0;
    PlayerDados[playerid][TempoRoubarDenovo] = 0;

    PlayerDados[playerid][DominandoTerritorio] = 0;

    PlayerDados[playerid][DominandoPista] = 0;
    PlayerDados[playerid][TentouDominarPista] = 0;
    PlayerDados[playerid][ProvocouPista] = 0;

    PlayerDados[playerid][DominandoCasarao] = 0;
    PlayerDados[playerid][TentouDominarCasarao] = 0;
    PlayerDados[playerid][ProvocouCasarao] = 0;

    PlayerDados[playerid][DominandoAlojamento] = 0;
    PlayerDados[playerid][TentouDominarAlojamento] = 0;
    PlayerDados[playerid][ProvocouAlojamento] = 0;

    PlayerDados[playerid][DominandoConstrucao] = 0;
    PlayerDados[playerid][TentouDominarConstrucao] = 0;
    PlayerDados[playerid][ProvocouConstrucao] = 0;

    PlayerDados[playerid][DominandoMadereira] = 0;
    PlayerDados[playerid][TentouDominarMadereira] = 0;
    PlayerDados[playerid][ProvocouMadereira] = 0;

    PlayerDados[playerid][GameTextDominar] = 0;
    PlayerDados[playerid][PararGameTextDominar] = 0;
    return 1;
}

stock NomeOrg(playerid) {
    new str[39];
    if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 0){ format(str, sizeof(str), "{9B30FF}Ballas{FFFFFF}"); }
    if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 1){ format(str, sizeof(str), "{008B00}Groove Street Families{FFFFFF}"); }
    if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 2){ format(str, sizeof(str), "{363636}The Lost MC{FFFFFF}"); }
    if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 3){ format(str, sizeof(str), "{1C1C1C}Outlaws MC{FFFFFF}"); }
    return str;
}

stock randomEx(min, max) {     
    new rand = random(max-min)+min;    
    return rand;
}

stock GetNumberTo(number1, number2) {
    new result_number;
    for(new i = 0; number1 <= number2; i++)
    {
        if(result_number + number1 == number2) return result_number;
        result_number++;
    }
    return 1;
}

stock GetPlayerPlatform(playerid) {
    new Plataforma[16];
    if(GetPVarInt(playerid, "NotAndroid") == 0) {
        Plataforma = "{A020F0}Android";
    } else {
        Plataforma = "{A020F0}PC";
    }
    return Plataforma;
}

stock GetOnlinePlayers() {
	new players;
	for(new x = 0; x < MAX_PLAYERS; x++) {
	  if(IsPlayerConnected(x))) { 
			players++;
		}
	}
	return players;
}

stock GetRoleName(playerid) {
    new Cargo[40];

    if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") == 4) {
        Cargo = "{A020F0}Fundador";
    }
    else if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") == 3) {
        Cargo = "{A020F0}Administrador";
    }
    else if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") == 2) {
        Cargo = "{A020F0}Moderador";
    }
    else if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") == 1) {
        Cargo = "{A020F0}Ajudante";
    }
    else if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") == 0) {
        if(DOF2_GetInt(GetAccount(playerid), "Policial") == 1) {
            Cargo = "{556B2F}Forcas Armadas";
        } else {
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 0) {
            Cargo = "{9B30FF}Ballas{FFFFFF}";
            }
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 1) { 
                Cargo = "{008B00}Groove Street Families{FFFFFF}";
            }
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 2) { 
                Cargo = "{363636}The Lost MC{FFFFFF}";
            }
            if(DOF2_GetInt(GetAccount(playerid), "OrgID") == 3) { 
                Cargo = "{1C1C1C}Outlaws MC{FFFFFF}";
            }
        }
    }
    return Cargo;
}

stock PreloadAnimationLib(playerid, animlib[]) {
    ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
}

stock DarDinamite(playerid) {
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 4) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 5);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 3) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 4);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 2) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 3);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 1) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 2);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 0) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 1);
        DOF2_SaveFile();
    }
    return 1;
}

stock TirarDinamite(playerid) {
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 1) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 0);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 2) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 1);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 3) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 2);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 4) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 3);
        DOF2_SaveFile();
    }
    if(DOF2_GetInt(GetAccount(playerid), "Dinamites") == 5) {
        DOF2_SetInt(GetAccount(playerid), "Dinamites", 4);
        DOF2_SaveFile();
    }
    return 1;
}

stock CorPista() {
    new Cor;
    if(DOF2_GetInt("Territorios/Pista.ini", "QuemDomina") == 0){
        Cor = COR_BALLAS;
    }
    if(DOF2_GetInt("Territorios/Pista.ini", "QuemDomina") == 1){
        Cor = COR_GROOVE;
    }
    if(DOF2_GetInt("Territorios/Pista.ini", "QuemDomina") == 2){
        Cor = COR_TLMC;
    }
    if(DOF2_GetInt("Territorios/Pista.ini", "QuemDomina") == 3){
        Cor = COR_OUTL;
    }
    return Cor;
}

stock CorCasarao() {
    new Cor;
    if(DOF2_GetInt("Territorios/Casarao.ini", "QuemDomina") == 0){
        Cor = COR_BALLAS;
    }
    if(DOF2_GetInt("Territorios/Casarao.ini", "QuemDomina") == 1){
        Cor = COR_GROOVE;
    }
    if(DOF2_GetInt("Territorios/Casarao.ini", "QuemDomina") == 2){
        Cor = COR_TLMC;
    }
    if(DOF2_GetInt("Territorios/Casarao.ini", "QuemDomina") == 3){
        Cor = COR_OUTL;
    }
    return Cor;
}

stock CorAlojamento() {
    new Cor;
    if(DOF2_GetInt("Territorios/Alojamento.ini", "QuemDomina") == 0){
        Cor = COR_BALLAS;
    }
    if(DOF2_GetInt("Territorios/Alojamento.ini", "QuemDomina") == 1){
        Cor = COR_GROOVE;
    }
    if(DOF2_GetInt("Territorios/Alojamento.ini", "QuemDomina") == 2){
        Cor = COR_TLMC;
    }
    if(DOF2_GetInt("Territorios/Alojamento.ini", "QuemDomina") == 3){
        Cor = COR_OUTL;
    }
    return Cor;
}

stock CorConstrucao() {
    new Cor;
    if(DOF2_GetInt("Territorios/Construcao.ini", "QuemDomina") == 0){
        Cor = COR_BALLAS;
    }
    if(DOF2_GetInt("Territorios/Construcao.ini", "QuemDomina") == 1){
        Cor = COR_GROOVE;
    }
    if(DOF2_GetInt("Territorios/Construcao.ini", "QuemDomina") == 2){
        Cor = COR_TLMC;
    }
    if(DOF2_GetInt("Territorios/Construcao.ini", "QuemDomina") == 3){
        Cor = COR_OUTL;
    }
    return Cor;
}

stock CorMadereira() {
    new Cor;
    if(DOF2_GetInt("Territorios/Madereira.ini", "QuemDomina") == 0) {
        Cor = COR_BALLAS;
    }
    if(DOF2_GetInt("Territorios/Madereira.ini", "QuemDomina") == 1) {
        Cor = COR_GROOVE;
    }
    if(DOF2_GetInt("Territorios/Madereira.ini", "QuemDomina") == 2) {
        Cor = COR_TLMC;
    }
    if(DOF2_GetInt("Territorios/Madereira.ini", "QuemDomina") == 3) {
        Cor = COR_OUTL;
    }
    return Cor;
}

// COMANDOS

// coord arena: 1416.107000,0.268620,1000.926000

CMD:ajuda(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(DOF2_GetInt(GetAccount(playerid), "LevelAdmin") > 0) {
        ShowPlayerDialog(playerid, DIALOG_AJUDA_STAFF, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Ajuda", "{A020F0}Ajuda: {FFFFFF}Comandos Gerais\n{A020F0}Ajuda: {FFFFFF}Comandos VIP\n{A020F0}Ajuda: {FFFFFF}Comandos Administrativos", "Selecionar", "Cancelar");
    } else {
        ShowPlayerDialog(playerid, DIALOG_AJUDA, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Ajuda", "{A020F0}Ajuda: {FFFFFF}Comandos Gerais\n{A020F0}Ajuda: {FFFFFF}Comandos VIP", "Selecionar", "Cancelar");
    }
    return 1;
}
alias:ajuda("help", "comandos");

CMD:info(playerid, params[]) {
    new string[512], id_jogador;
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(sscanf(params, "u", id_jogador)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Modo de uso: /info [id]");
    if(!IsPlayerConnected(id_jogador)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Nenhum jogador com este ID foi encontrado.");
    if(id_jogador != playerid && DOF2_GetInt(GetAccount(id_jogador), "VerInfos") == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Este usuario prefere nao compartilhar suas informacoes.");

    format(string, sizeof(string), "{FFFFFF}Informacoes de: {A020F0}%s\n\t{FFFFFF}Plataforma: %s\n\tOrganizacao: %s\n\tScore: %d\n\tDinamites: %d/5\n\tEliminacoes: %d\n\tMortes: %d", PlayerNome(id_jogador), GetPlayerPlatform(id_jogador), NomeOrg(id_jogador), GetPlayerScore(id_jogador), DOF2_GetInt(GetAccount(id_jogador), "Dinamites"), DOF2_GetInt(GetAccount(id_jogador), "Eliminacoes"), DOF2_GetInt(GetAccount(id_jogador), "Mortes"));
    ShowPlayerDialog(playerid, DIALOG_JOGADOR_INFO, DIALOG_STYLE_MSGBOX, "{FFFFFF}Street Wars - Info", string, "", "Fechar");
    return 1;
}
alias:info("player", "playerinfo")

CMD:mudar(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(GetPlayerMoney(playerid) < 1500) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinheiro suficiente ({33AA33}$1500{FFFFFF}).");
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce devera sair do veiculo para isso.");
    ShowPlayerDialog(playerid, DIALOG_MUDAR_ORG, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Mudar Org", "{A020F0}0 {FFFFFF}- Gangue: Ballas\n{A020F0}1 {FFFFFF}- Gangue: Groove Street Families\n{A020F0}2 {FFFFFF}- Motoclube: The Lost MC\n{A020F0}3 {FFFFFF}- Motoclube: Outlaws MC", "Selecionar", "Cancelar");
    return 1;
}

CMD:menu(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    ShowPlayerDialog(playerid, DIALOG_MENU, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Menu", "{A020F0}Menu: {FFFFFF}Configuracoes\n{A020F0}Menu: {FFFFFF}Conquistas\n{A020F0}Menu: {FFFFFF}Habilidades", "Selecionar", "Cancelar");
    return 1;
}

CMD:gps(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para isso.");
    ShowPlayerDialog(playerid, DIALOG_GPS_SELECAO, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - GPS", "{A020F0}0 {FFFFFF}- Territorios\n{A020F0}1 {FFFFFF}- Locais de Roubo\n{A020F0}2 {FFFFFF}- Lojas de Arma\n{A020F0}3 {FFFFFF}- Comerciantes", "Selecionar", "Cancelar");
    return 1;
}

CMD:criarveiculo(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(PlayerDados[playerid][CriouVeiculo] == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja possui um veiculo criado.");
    if(GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao pode criar veiculos em um interior.");
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar fora de um veiculo para fazer isso.");
    ShowPlayerDialog(playerid, DIALOG_VEICULOS, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Veiculos", "{A020F0}Veiculo: {FFFFFF}Faggio\n{A020F0}Veiculo: {FFFFFF}Landstalker", "Selecionar", "Cancelar");
    return 1;
}

CMD:destruirveiculo(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(PlayerDados[playerid][CriouVeiculo] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui um veiculo criado.");
    DestroyVehicle(Veiculo);
    SendClientMessage(playerid, VERDE, "INFO || {FFFFFF}Veiculo destruido com sucesso.");
    PlayerDados[playerid][CriouVeiculo] = 0;
    return 1;
}

CMD:dinamitar(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 824.72595214, 10.20378112, 1004.17968750)) {
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao esta em um local dinamitavel.");
    } else {
        if(PortaLotericaExplodida == 1) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}A porta do cofre ja esta explodida.");
        if(DOF2_GetInt(GetAccount(playerid), "Dinamites") < 1) {
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao possui dinamites para explodir a porta do cofre.");
        } else {
            TirarDinamite(playerid);
            SetTimerEx("ExplosaoPortaLoterica", 3000, false, "i", playerid);
            ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 1.0, 0, 0, 0, 0, 3000, 1);

            new str[132];
            format(str, sizeof(str), "INFO || {FFFFFF}%s(ID: %d) esta tentando explodir a porta do cofre da loterica.", PlayerNome(playerid), playerid);
            SendClientMessageToAll(AZUL, str);
        }
    }
    return 1;
}

CMD:roubar(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(IsPlayerInRangeOfPoint(playerid, 6.0, 820.70001, 11.6, 1003.6)) {
        if(PortaLotericaExplodida == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}A porta do cofre precisa estar explodida para isso.");
        if(PlayerDados[playerid][RoubouGranaLoterica] == 3) {
            SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce ja roubou 3 malotes de dinheiro, devera aguardar para roubar mais.");
        } else {
            new grana, string[164];
            if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 0) {
                grana = randomEx(328, 2456);
                GivePlayerMoney(playerid, grana);
                PlayerDados[playerid][RoubouGranaLoterica]++;
                PlayerDados[playerid][TempoRoubarDenovo] = SetTimerEx("TempoRoubarLotericaDenovo", 300000, true, "i", playerid);
                format(string, sizeof(string), "INFO || {FFFFFF}Por ter Habilidade de Roubo nivel 0, voce pegou um malote que havia {33AA33}$%d {FFFFFF}de dinheiro.", grana);
            }
            else if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 1) {
                grana = randomEx(617, 3102);
                GivePlayerMoney(playerid, grana);
                PlayerDados[playerid][RoubouGranaLoterica]++;
                PlayerDados[playerid][TempoRoubarDenovo] = SetTimerEx("TempoRoubarLotericaDenovo", 300000, true, "i", playerid);
                format(string, sizeof(string), "INFO || {FFFFFF}Por ter Habilidade de Roubo nivel 1, voce pegou um malote que havia {33AA33}$%d {FFFFFF}de dinheiro.", grana);
            }
            else if(DOF2_GetInt(GetAccount(playerid), "HabilidadeRoubo") == 2) {
                grana = randomEx(804, 2977);
                GivePlayerMoney(playerid, grana);
                PlayerDados[playerid][RoubouGranaLoterica]++;
                PlayerDados[playerid][TempoRoubarDenovo] = SetTimerEx("TempoRoubarLotericaDenovo", 300000, true, "i", playerid);
                format(string, sizeof(string), "INFO || {FFFFFF}Por ter Habilidade de Roubo nivel 2, voce pegou um malote que havia {33AA33}$%d {FFFFFF}de dinheiro.", grana);
            }
            SendClientMessage(playerid, VERDE, string);
        }
    } else {
        SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao esta em um local roubavel.");
    }
    return 1;
}

// COMANDOS VIP

CMD:tag(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao e um usuario VIP.");
    ShowPlayerDialog(playerid, DIALOG_VIP_TAG, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Tag VIP", "{A020F0}0 {FFFFFF}- {00FF00}Verde\n{A020F0}1 {FFFFFF}- {0000FF}Azul\n{A020F0}2 {FFFFFF}- {FFFF00}Amarelo\n{A020F0}3 {FFFFFF}- {FF8000}Laranja\n{A020F0}4 {FFFFFF}- {FF0000}Vermelho\n{A020F0}5 {FFFFFF}- {FE2EF7}Rosa", "Selecionar", "Cancelar");
    return 1;
}

CMD:acessorios(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao e um usuario VIP.");
    ShowPlayerDialog(playerid, DIALOG_VIP_ACESSORIOS, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Acessorios VIP", "{A020F0}0 {FFFFFF}- Cabeca\n{A020F0}1 {FFFFFF}- Torso", "Selecionar", "Cancelar");
    return 1;
}

CMD:tunar(playerid, params[]) {
    if(PlayerDados[playerid][Logado] == 0) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar logado para fazer isso.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce precisa estar em um veiculo para fazer isso.");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, VERMELHO, "ERRO || {FFFFFF}Voce nao esta dirigindo nenhum veiculo.");
    if(strcmp("true", DOF2_GetString(GetAccount(playerid), "VIP"))) {
        ShowPlayerDialog(playerid, DIALOG_TUNAR, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Tunar", "{A020F0}0 {FFFFFF}- Nitro", "Selecionar", "Cancelar");
    } else {
        ShowPlayerDialog(playerid, DIALOG_TUNAR, DIALOG_STYLE_LIST, "{FFFFFF}Street Wars - Tunar VIP", "{A020F0}0 {FFFFFF}- Nitro\n{A020F0}1 {FFFFFF}- Sistema Hidraulico\n{A020F0}2 {FFFFFF}- Rodas", "Selecionar", "Cancelar");
    }
    return 1;
}

// COMANDOS TESTE

CMD:reparar(playerid, params[]) {
    new VeiculoReparo;
    VeiculoReparo = GetPlayerVehicleID(playerid);
    RepairVehicle(VeiculoReparo);
    SendClientMessage(playerid, VERDE, "VIP || {FFFFFF}Veiculo reparado com sucesso.");
    return 1;
}

CMD:score(playerid, params[]) {
    SetPlayerScore(playerid, GetPlayerScore(playerid)+10);
    SendClientMessage(playerid, VERDE_AMARELADO, "10 SCORES SETADOS.");
    return 1;
}
