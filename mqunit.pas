unit mqunit;

{
 *
 * Acces a la API de MQ.
 * MQIS -> Server libraries + mq_basic
 * MQIC -> Client libraries + mq_basicC
 *
 * Versions :
 *  1.0.a - 20150520 - problemes doble char
 *  1.0.b - 20150602 - open() queue
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

const
  szProducte = 'MQ API access from Delphi' ;
  szAutor    = 'sag@tinet.cat' ;
  szVersio   = 'v 1.0.b, 20150602' ;


type
  TfMQ = class(TForm)
    btnConnect: TButton;
    edQMN: TEdit;
    edCH: TEdit;
    lbEvents: TListBox;
    Timer1: TTimer;
    edQUNM: TEdit;
    btnOpen: TButton;
    edObjH: TEdit;
    procedure MyInit(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
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

  sz48QMN     : MQCHAR48 ;       // queue manager name
  hConexio    : THandle ;        // Connect() handle
  szhConexio  : string ;

  sz48QUEUENM : MQCHAR48 ;       // queue name
  hOpen       : THandle ;        // Open() handle
  szhOpen     : string ;

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
  strpcopy( sz48QMN, szUsrQMN ) ;
  Hex_Dump ( fMQ.lbEvents, 'QMname', @ sz48QMN, sizeof (sz48QMN) ) ;

  iLng := sizeof( sz48QMN ) ;
  SAGdebugMsg ( fMQ.lbEvents, '>>> Lets connect to QMGR [lng '+IntToStr(iLng)+']-('+ sz48QMN +').' ) ;

  hConexio := ConnectMQ ( fMQ.lbEvents, sz48QMN ) ;
  szhConexio := IntToStr( hConexio ) ;
  edCH.Text := szhConexio ;

  SAGdebugMsg ( fMQ.lbEvents, '+-+-+- Resultat handleConexio(' + szhConexio + ').' ) ;

//
//   MQCONN ( @ szQMN, @ hConexio, @ cc, @ rc ) ;
//   if ( cc > 0 ) then hConexio := 0 ;
//   SAGdebugMsg ( fMQ.lbEvents, '+-+-+- Resultat handleConexio(' + szhConexio + ') CC/RC('+IntToStr(cc)+ '/' + IntToStr(rc)+').' ) ;
//

end; // TfMQ.btnConnectClick


procedure TfMQ.btnOpenClick(Sender: TObject);
var
  szUsrQueueName : AnsiString ;
  iLng           : integer ;
  oo             : integer ;  // Open Options
  od             : MQOD ;     // Object Descriptor

begin

  szUsrQueueName := edQUNM.Text ;
  strpcopy( sz48QUEUENM, szUsrQueueName ) ;

  iLng := sizeof( sz48QUEUENM ) ;
  SAGdebugMsg ( fMQ.lbEvents, '>>> Lets OPEN() Queue [lng '+IntToStr(iLng)+']-('+ sz48QUEUENM +').' ) ;

  oo := MQOO_INPUT_SHARED + MQOO_FAIL_IF_QUIESCING ;

  // init Object Descriptor fields with default values, then set few values
  move ( MQOD_DEFAULT, od, sizeof (MQOD_DEFAULT) ) ;  // source, destination, count.
  od.Version := MQOD_VERSION_3 ;

  strplcopy ( od.ObjectQMgrName, sz48QMN, MQ_Q_MGR_NAME_LENGTH ) ;
  strplcopy ( od.ObjectName, sz48QUEUENM, sizeof(od.ObjectName)-1 ) ;

  hOpen := MQ_Open_Queue ( fMQ.lbEvents, hConexio, sz48QUEUENM, od, oo ) ; // hOpen = 0 if error

  szhOpen := IntToStr( hOpen ) ;
  edObjH.Text := szhOpen ;

  SAGdebugMsg ( fMQ.lbEvents, '+-+-+- Resultat handleOpen(' + szhOpen + ').' ) ;

end; // TfMQ.btnOpenClick


procedure TfMQ.MyInit(Sender: TObject);
begin
  edQMN.Text := 'QMV75' ;
  edQMN.Text := 'SAG.SVRCONN/TCP/9.137.165.71(1955)' ;   // QM_CNT at T430 - v 7.5
  edQMN.Text := 'SEBAS.SVRCONN/TCP/9.137.166.87(2415)' ; // P7029 at Linux - v 7.5
  edQMN.Text := 'QM_CNT' ;                               // T430
  edQMN.Text := 'QMU' ;                                  // T440
  edQMN.Text := 'QM_CNT' ;                               // W500
  edCH.Text := '-' ;

  edQUNM.Text := 'QL.IN' ;
  edObjH.Text := '-' ;

  Timer1.Enabled := false ;
  hConexio := 0 ;
end; // OnCreate() -> TfMQ.MyInit

end.
