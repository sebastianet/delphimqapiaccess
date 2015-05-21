unit mqunit;

{
 *
 * Acces a la API de MQ.
 * MQIS -> Server libraries + mq_basic
 * MQIC -> Client libraries + mq_basicC
 *
 *}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  MQIS, mq_basic,
  sag_hexdump,        // provide pointer and count ...
//  MQIC,
//  mq_basicC,
  SAG_debug ;

type
  TfMQ = class(TForm)
    btnConnect: TButton;
    edQMN: TEdit;
    edCH: TEdit;
    lbEvents: TListBox;
    Timer1: TTimer;
    procedure MyInit(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//    MQCHAR48   = array [0..47]  of AnsiChar ;
//    PMQCHAR48  = ^MQCHAR48 ;
//    MQLONG     = Longint;
//    PMQLONG    = ^MQLONG;
//    MQHCONN    = MQLONG;
//    PMQHCONN   = ^MQHCONN;

var
  fMQ         : TfMQ;
  szQMN       : MQCHAR48 ; // queue manager name
  hConexio    : THandle ;
  szhConexio  : string ;

implementation

{$R *.dfm}

// procedure MQCONN ( pQMgrName: PMQCHAR48;
//                    pHConn: PMQHCONN;
//                    pCompcode, pReason: PMQLONG ) ; cdecl; external 'MQM.DLL' ;

procedure TfMQ.btnConnectClick(Sender: TObject);
var
  szUsrQMN : AnsiString ;
  iLng     : integer ;
//  cc, rc : integer ;

begin

  szUsrQMN := edQMN.Text ; // implicit type cast

//  Hex_Dump ( fMQ.lbEvents, 'QMnameUser', @ szUsrQMN, sizeof (szUsrQMN) ) ;

//  szQMN :=  '                                                ' ; // init 48byte array
  strpcopy( szQMN, szUsrQMN ) ;
  Hex_Dump ( fMQ.lbEvents, 'QMname', @ szQMN, sizeof (szQMN) ) ;

  iLng := sizeof( szQMN ) ;
  SAGdebugMsg ( fMQ.lbEvents, '>>> Lets connect to QMGR ['+IntToStr(iLng)+']-('+ szQMN +').' ) ;

  hConexio := ConnectMQ ( fMQ.lbEvents, szQMN ) ;
  szhConexio := IntToStr(hConexio) ;
  edCH.Text := szhConexio ;

  SAGdebugMsg ( fMQ.lbEvents, '+-+-+- Resultat handleConexio(' + szhConexio + ').' ) ;

//
//   MQCONN ( @ szQMN, @ hConexio, @ cc, @ rc ) ;
//   if ( cc > 0 ) then hConexio := 0 ;
//   SAGdebugMsg ( fMQ.lbEvents, '+-+-+- Resultat handleConexio(' + szhConexio + ') CC/RC('+IntToStr(cc)+ '/' + IntToStr(rc)+').' ) ;
//

end; // TfMQ.btnConnectClick


procedure TfMQ.MyInit(Sender: TObject);
begin
  edQMN.Text := 'QMV75' ;
  edQMN.Text := 'SAG.SVRCONN/TCP/9.137.165.71(1955)' ;   // QM_CNT at T430 - v 7.5
  edQMN.Text := 'SEBAS.SVRCONN/TCP/9.137.166.87(2415)' ; // P7029 at Linux - v 7.5
  edQMN.Text := 'QM_CNT' ;                               // T430
  edQMN.Text := 'QMU' ;                                  // T440
  edCH.Text := '-' ;

  Timer1.Enabled := false ;
  hConexio := 0 ;
end;

end.
