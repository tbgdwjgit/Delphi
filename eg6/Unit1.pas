unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;



type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure MessageEvent(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
    oldPoint,newPoint:TPoint;
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}







procedure TForm1.Button1Click(Sender: TObject);
begin//ʹ��API: GetAsyncKeyState���ʺ�ʵʱ��⣬�ж�����Ƿ������
 //if (Windows.GetAsyncKeyState(VK_LBUTTON) and $FF00) > 0 then
  if Windows.GetAsyncKeyState(VK_LBUTTON) > 0 then
    Showmessage('���');

  {
  ע��GetAsyncKeyStateҲ�������ڼ����̸��ְ�����״̬������Լ��CTRL������F1�������Ƿ��£������MSDN��
  ��ʱ���ж�����ʱ���Ƚ����⣬��Ҫ���û����������ȥ��⣬��ʱ��API��û�����ģ���ΪAPI�ǻ�ȡ��ǰʱ�̵�״̬���û����º�
  ��갴���Ѿ����ſ�����ʱ��ʹ��APIȥ��⣬ֻ�ܼ�⵽û����갴�����£����������������Ҫʹ��������Ϣ�ķ�ʽ��
  }



  GetCursorPos(oldPoint); //���浱ǰ���λ�á�
  newPoint.x := oldPoint.x+20;
  newPoint.y := oldPoint.y+10;

  //SetCursorPos(newPoint.x,newPoint.y); //����Ŀ�ĵ�λ�á�

  SetCursorPos(oldPoint.x,oldPoint.y);

  //mouse_event(MOUSEEVENTF_RIGHTDOWN,0,0,0,0);//ģ�ⰴ������Ҽ���
  //mouse_event(MOUSEEVENTF_RIGHTUP,0,0,0,0);//ģ��ſ�����Ҽ���
  mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);//ģ�ⰴ����������
  mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);//ģ��ſ���������
  keybd_event(VK_SHIFT,MapVirtualKey(VK_SHIFT,0),0,0); //����SHIFT����
  //keybd_event(0x52,MapVirtualKey(0x52,0),0,0);//����R����
  //keybd_event(0x52,MapVirtualKey(0x52,0),KEYEVENTF_KEYUP,0);//�ſ�R����
  keybd_event(VK_SHIFT,MapVirtualKey(VK_SHIFT,0),KEYEVENTF_KEYUP,0);//�ſ�SHIFT����




end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Showmessage('����');
  {if Windows.GetAsyncKeyState(VK_RBUTTON) > 0 then
    Showmessage('�Ҽ�');
  if Windows.GetAsyncKeyState(VK_MBUTTON) > 0 then
    Showmessage('����');}
end;

procedure TForm1.MessageEvent(var Msg: TMsg; var Handled: Boolean);
begin
 if Msg.message = WM_LBUTTONDOWN then
 begin
   Showmessage('����');
   //�����������£���������ʹ��������Ϣ���� WM_RBUTTONDOWN��WM_MBUTTONDOWN��
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.OnMessage := MessageEvent; //�������Form��WndProc���ڹ��̣����޷���⵽�ؼ���˵��ȵ���Ϣ
end;

end.

{
1. API֮���纯��
 WNetAddConnection ����ͬһ��������Դ������������ 

WNetAddConnection2 ����ͬһ��������Դ������
WNetAddConnection3 ����ͬһ��������Դ������
WNetCancelConnection ����һ����������
WNetCancelConnection2 ����һ����������
WNetCloseEnum ����һ��ö�ٲ���
WNetConnectionDialog ����һ����׼�Ի����Ա㽨��ͬ������Դ������
WNetDisconnectDialog ����һ����׼�Ի����Ա�Ͽ�ͬ������Դ������
WNetEnumResource ö��������Դ
WNetGetConnection ��ȡ���ػ������ӵ�һ����Դ����������
WNetGetLastError ��ȡ����������չ������Ϣ
WNetGetUniversalName ��ȡ������һ���ļ���Զ�������Լ�/����UNC��ͳһ�����淶������
WNetGetUser ��ȡһ��������Դ�������ӵ�����
WNetOpenEnum ������������Դ����ö�ٵĹ���

 

2. API֮��Ϣ����

BroadcastSystemMessage ��һ��ϵͳ��Ϣ�㲥��ϵͳ�����еĶ�������
GetMessagePos ȡ����Ϣ��������һ����Ϣ�������ʱ�����ָ����Ļλ��
GetMessageTime ȡ����Ϣ��������һ����Ϣ�������ʱ��ʱ��
PostMessage ��һ����ϢͶ�ݵ�ָ�����ڵ���Ϣ����
PostThreadMessage ��һ����ϢͶ�ݸ�Ӧ�ó���
RegisterWindowMessage ��ȡ�����һ���ִ���ʶ������Ϣ���
ReplyMessage ��һ����Ϣ
SendMessage ����һ�����ڵĴ��ں�������һ����Ϣ�����Ǹ�����
SendMessageCallback ��һ����Ϣ��������
SendMessageTimeout �򴰿ڷ���һ����Ϣ
SendNotifyMessage �򴰿ڷ���һ����Ϣ

3. API֮�ļ�������

CloseHandle �ر�һ���ں˶������а����ļ����ļ�ӳ�䡢���̡��̡߳���ȫ��ͬ�������
CompareFileTime �Ա������ļ���ʱ��
CopyFile �����ļ�
CreateDirectory ����һ����Ŀ¼
CreateFile �򿪺ʹ����ļ����ܵ����ʲۡ�ͨ�ŷ����豸�Լ�����̨
CreateFileMapping ����һ���µ��ļ�ӳ�����
DeleteFile ɾ��ָ���ļ�
DeviceIoControl ���豸ִ��ָ���Ĳ���
DosDateTimeToFileTime ��DOS���ں�ʱ��ֵת����һ�� win32 FILETIME ֵ
FileTimeToDosDateTime ��һ�� win32 FILETIME ֵת����DOS���ں�ʱ��ֵ
FileTimeToLocalFileTime ��һ��FILETIME�ṹת���ɱ���ʱ��
FileTimeToSystemTime ����һ��FILETIME�ṹ�����ݣ�װ��һ��SYSTEMTIME�ṹ
FindClose �ر���FindFirstFile����������һ���������
FindFirstFile �����ļ��������ļ�
FindNextFile ���ݵ���FindFirstFile����ʱָ����һ���ļ���������һ���ļ�
FlushFileBuffers ���ָ�����ļ������ˢ���ڲ��ļ�������
FlushViewOfFile ��д���ļ�ӳ�仺�������������ݶ�ˢ�µ�����
GetBinaryType �ж��ļ��Ƿ����ִ��
GetCompressedFileSize �ж�һ��ѹ���ļ��ڴ�����ʵ��ռ�ݵ��ֽ���
GetCurrentDirectory ��һ����������װ�ص�ǰĿ¼
GetDiskFreeSpace ��ȡ��һ�����̵���֯�йص���Ϣ���Լ��˽�ʣ��ռ������
GetDiskFreeSpaceEx ��ȡ��һ�����̵���֯�Լ�ʣ��ռ������йص���Ϣ
GetDriveType �ж�һ������������������
GetExpandedName ȡ��һ��ѹ���ļ���ȫ��
GetFileAttributes �ж�ָ���ļ�������
GetFileInformationByHandle ��������ṩ�˻�ȡ�ļ���Ϣ��һ�ֻ���
GetFileSize �ж��ļ�����
GetFileTime ȡ��ָ���ļ���ʱ����Ϣ
GetFileType �ڸ����ļ������ǰ���£��ж��ļ�����
GetFileVersionInfo ��֧�ְ汾��ǵ�һ��ģ�����ȡ�ļ��汾��Ϣ
GetFileVersionInfoSize ��԰����˰汾��Դ��һ���ļ����ж������ļ��汾��Ϣ��Ҫһ�����Ļ�����
GetFullPathName ��ȡָ���ļ�������·����
GetLogicalDrives �ж�ϵͳ�д�����Щ�߼���������ĸ
GetLogicalDriveStrings ��ȡһ���ִ������а����˵�ǰ�����߼��������ĸ�������·��
GetOverlappedResult �ж�һ���ص�������ǰ��״̬
GetPrivateProfileInt Ϊ��ʼ���ļ���.ini�ļ�����ָ������Ŀ��ȡһ������ֵ
GetPrivateProfileSection ��ȡָ��С�ڣ���.ini�ļ��У�����������ֵ��һ���б�
GetPrivateProfileString Ϊ��ʼ���ļ���ָ������Ŀȡ���ִ�
GetProfileInt ȡ��win.ini��ʼ���ļ���ָ����Ŀ��һ������ֵ
GetProfileSection ��ȡָ��С�ڣ���win.ini�ļ��У�����������ֵ��һ���б�
GetProfileString Ϊwin.ini��ʼ���ļ���ָ������Ŀȡ���ִ�
GetShortPathName ��ȡָ���ļ��Ķ�·����
GetSystemDirectory ȡ��WindowsϵͳĿ¼����SystemĿ¼��������·����
GetTempFileName �������������һ����ʱ�ļ������֣�������Ӧ�ó���ʹ��
GetTempPath ��ȡΪ��ʱ�ļ�ָ����·��
GetVolumeInformation ��ȡ��һ�����̾��йص���Ϣ
GetWindowsDirectory ��ȡWindowsĿ¼������·����
hread �ο�lread
hwrite �ο�lwrite����
lclose �ر�ָ�����ļ�
lcreat ����һ���ļ�
llseek �����ļ��н��ж�д�ĵ�ǰλ��
LockFile �����ļ���ĳһ���֣�ʹ�䲻������Ӧ�ó�����
LockFileEx ��LockFile���ƣ�ֻ�����ṩ�˸���Ĺ���
lopen �Զ�����ģʽ��ָ�����ļ�
lread ���ļ��е����ݶ����ڴ滺����
lwrite �����ݴ��ڴ滺����д��һ���ļ�
LZClose �ر���LZOpenFile �� LZInit�����򿪵�һ���ļ�
LZCopy ����һ���ļ�
LZInit ����������ڳ�ʼ���ڲ�������
LZOpenFile �ú�����ִ�д�����ͬ���ļ��������Ҽ�����ѹ���ļ�
LZRead �����ݴ��ļ������ڴ滺����
LZSeek ����һ���ļ��н��ж�д�ĵ�ǰλ��
MapViewOfFile ��һ���ļ�ӳ�����ӳ�䵽��ǰӦ�ó���ĵ�ַ�ռ�
MoveFile �ƶ��ļ�
OpenFile ���������ִ�д�����ͬ���ļ�����
OpenFileMapping ��һ���ֳɵ��ļ�ӳ�����
QueryDosDevice ��Windows NT�У�DOS�豸����ӳ���NTϵͳ�豸�����ú������жϵ�ǰ���豸ӳ�����
ReadFile ���ļ��ж�������
ReadFileEx ��ReadFile���ƣ�ֻ����ֻ�������첽����������������һ�������Ļص�
RegCloseKey �ر�ϵͳע����е�һ��������
RegConnectRegistry ����Զ��ϵͳ�Ĳ���ע���
RegCreateKey ��ָ�������´������һ����
RegCreateKeyEx ��ָ�����´�������ĸ����ӵķ�ʽ����Win32�����н���ʹ���������
RegDeleteKey ɾ���������·�һ��ָ��������
RegDeleteValue ɾ��ָ�����·���һ��ֵ
RegEnumKey ö��ָ����������Win32������Ӧʹ��RegEnumKeyEx
RegEnumKeyEx ö��ָ�����·�������
RegEnumValue ö��ָ�����ֵ
RegFlushKey ��������������������ĸĶ�ʵ��д�����
RegGetKeySecurity ��ȡ��һ��ע������йصİ�ȫ��Ϣ
RegLoadKey ����ǰ��RegSaveKey����������һ���ļ���װ��ע�����Ϣ
RegNotifyChangeKeyValue ע�����������κ�һ��������仯ʱ������������ṩһ��֪ͨ����
RegOpenKey ��һ�����е�ע�����
RegOpenKeyEx ��һ�����е����win32���Ƽ�ʹ���������
RegQueryInfoKey ��ȡ��һ�����йص���Ϣ
RegQueryValue ȡ��ָ����������Ĭ�ϣ�δ������ֵ
RegQueryValueEx ��ȡһ���������ֵ
RegReplaceKey ��һ�������ļ��������Ϣ�滻ע�����Ϣ��������һ�����ݣ������а�����ǰע�����Ϣ
RegRestoreKey ��һ�������ļ��ָ�ע�����Ϣ
RegSaveKey ��һ�����Լ���������������浽һ�������ļ�
RegSetKeySecurity ����ָ����İ�ȫ����
RegSetValue ����ָ����������Ĭ��ֵ
RegSetValueEx ����ָ�����ֵ
RegUnLoadKey ж��ָ�������Լ�������������
RemoveDirectory ɾ��ָ��Ŀ¼
SearchPath ����ָ���ļ�
SetCurrentDirectory ���õ�ǰĿ¼
SetEndOfFile ���һ���򿪵��ļ�������ǰ�ļ�λ����Ϊ�ļ�ĩβ
SetFileAttributes �����ļ�����
SetFilePointer ��һ���ļ������õ�ǰ�Ķ�дλ��
SetFileTime �����ļ��Ĵ��������ʼ��ϴ��޸�ʱ��
SetHandleCount �������������win32��ʹ�ã���ʹʹ�ã�Ҳ�������κ�Ч��
SetVolumeLabel ����һ�����̵ľ�꣨Label��
SystemTimeToFileTime ����һ��FILETIME�ṹ�����ݣ�����һ��SYSTEMTIME�ṹ
UnlockFile �����һ���ļ�������
UnlockFileEx �����һ���ļ�������
UnmapViewOfFile �ڵ�ǰӦ�ó�����ڴ��ַ�ռ�����һ���ļ�ӳ������ӳ��
VerFindFile �������������һ���ļ�Ӧ��װ������
VerInstallFile �����������װһ���ļ�
VerLanguageName ��������ܸ���16λ���Դ����ȡһ�����Ե�����

WriteFile ������д��һ���ļ�
WriteFileEx ��WriteFile���ƣ�ֻ����ֻ�������첽д��������������һ�������Ļص�
WritePrivateProfileSection Ϊһ����ʼ���ļ���.ini����ָ����С����������������ֵ
WritePrivateProfileString �ڳ�ʼ���ļ�ָ��С��������һ���ִ�
WriteProfileSection ΪWin.ini��ʼ���ļ���һ��ָ����С����������������ֵ
WriteProfileString ��Win.ini��ʼ���ļ�ָ��С��������һ���ִ�

 

 

 
GetWindowText ȡ��һ������ı��⣨caption�����֣�����һ���ؼ�������
GetWindowTextLength ���鴰�ڱ������ֻ�ؼ����ݵĳ���
GetWindowWord ���ָ�����ڽṹ����Ϣ
InflateRect ������Сһ�����εĴ�С
IntersectRect ���������lpDestRect������һ�����Σ�����lpSrc1Rect��lpSrc2Rect�������εĽ���
InvalidateRect ����һ�����ڿͻ�����ȫ���򲿷�����
IsChild �ж�һ�������Ƿ�Ϊ��һ���ڵ��ӻ���������
IsIconic �жϴ����Ƿ�����С��
IsRectEmpty �ж�һ�������Ƿ�Ϊ��
IsWindow �ж�һ�����ھ���Ƿ���Ч
IsWindowEnabled �жϴ����Ƿ��ڻ״̬
IsWindowUnicode �ж�һ�������Ƿ�ΪUnicode���ڡ�����ζ�Ŵ���Ϊ���л����ı�����Ϣ������Unicode����
IsWindowVisible �жϴ����Ƿ�ɼ�
IsZoomed �жϴ����Ƿ����
LockWindowUpdate ����ָ�����ڣ���ֹ������
MapWindowPoints ��һ�����ڿͻ�������ĵ�ת������һ���ڵĿͻ�������ϵͳ
MoveWindow �ı�ָ�����ڵ�λ�úʹ�С
OffsetRect ͨ��Ӧ��һ��ָ����ƫ�ƣ��Ӷ��þ����ƶ�����
OpenIcon �ָ�һ����С���ĳ��򣬲����伤��
PtInRect �ж�ָ���ĵ��Ƿ�λ�ھ����ڲ�
RedrawWindow �ػ�ȫ���򲿷ִ���
ReleaseCapture Ϊ��ǰ��Ӧ�ó����ͷ���겶��
ScreenToClient �ж���Ļ��һ��ָ����Ŀͻ�������
ScrollWindow �������ڿͻ�����ȫ����һ����
ScrollWindowEx ���ݸ��ӵ�ѡ��������ڿͻ�����ȫ���򲿷�
SetActiveWindow ����ָ���Ĵ���
SetCapture ����겶�����õ�ָ���Ĵ���
SetClassLong Ϊ����������һ��Long������Ŀ
SetClassWord Ϊ����������һ����Ŀ
SetFocusAPI �����뽹���赽ָ���Ĵ��ڡ����б�Ҫ���ἤ���
SetForegroundWindow ��������Ϊϵͳ��ǰ̨����
SetParent ָ��һ�����ڵ��¸�
SetRect ����ָ�����ε�����
SetRectEmpty ��������Ϊһ���վ���
SetWindowContextHelpId Ϊָ���Ĵ������ð��������������ģ�ID
SetWindowLong �ڴ��ڽṹ��Ϊָ���Ĵ���������Ϣ
SetWindowPlacement ���ô���״̬��λ����Ϣ
SetWindowPos Ϊ����ָ��һ����λ�ú�״̬
SetWindowText ���ô��ڵı������ֻ�ؼ�������
SetWindowWord �ڴ��ڽṹ��Ϊָ���Ĵ���������Ϣ
ShowOwnedPopups ��ʾ��������ָ���������е�ȫ������ʽ����
ShowWindow ���ƴ��ڵĿɼ���
ShowWindowAsync ��ShowWindow����
SubtractRect װ�ؾ���lprcDst�������ھ���lprcSrc1�м�ȥlprcSrc2�õ��Ľ��
TileWindows ��ƽ��˳�����д���
UnionRect װ��һ��lpDestRectĿ����Σ�����lpSrc1Rect��lpSrc2Rect���������Ľ��
UpdateWindow ǿ���������´���
ValidateRect У�鴰�ڵ�ȫ���򲿷ֿͻ���
WindowFromPoint ���ذ�����ָ����Ĵ��ڵľ�����������Ρ������Լ�͸������
 

 
 

 
4. API֮��ӡ����
AbortDoc ȡ��һ���ĵ��Ĵ�ӡ
AbortPrinter ɾ����һ̨��ӡ��������һ��Ļ����ļ�
AddForm Ϊ��ӡ���ı��б����һ���±�
AddJob ���ڻ�ȡһ����Ч��·�������Ա�����Ϊ��ҵ����һ����̨��ӡ�ļ�����Ҳ��Ϊ��ҵ����һ����ҵ���
AddMonitor Ϊϵͳ���һ����ӡ��������
AddPort ��������Ӷ˿ڡ��Ի��������û���ϵͳ���ö˿��б��м���һ���¶˿�
AddPrinter ��ϵͳ�����һ̨�´�ӡ��
AddPrinterConnection ����ָ���Ĵ�ӡ��
AddPrinterDriver Ϊָ����ϵͳ���һ����ӡ��������
AddPrintProcessor Ϊָ����ϵͳ���һ����ӡ������
AddPrintProvidor Ϊϵͳ���һ����ӡ��Ӧ��
AdvancedDocumentProperties ������ӡ���ĵ����öԻ���
ClosePrinter �ر�һ���򿪵Ĵ�ӡ������
ConfigurePort ���ָ���Ķ˿ڣ�����һ���˿����öԻ���
ConnectToPrinterDlg �������Ӵ�ӡ���Ի�������ͬ��������Ĵ�ӡ������
DeleteForm �Ӵ�ӡ�����ñ��б���ɾ��һ����
DeleteMonitor ɾ��ָ���Ĵ�ӡ������
DeletePort ������ɾ���˿ڡ��Ի��������û��ӵ�ǰϵͳɾ��һ���˿�
DeletePrinter ��ָ���Ĵ�ӡ����־Ϊ��ϵͳ��ɾ��
DeletePrinterConnection ɾ����ָ����ӡ��������
DeletePrinterDriver ��ϵͳɾ��һ����ӡ����������
DeletePrintProcessor ��ָ��ϵͳɾ��һ����ӡ������
DeletePrintProvidor ��ϵͳ��ɾ��һ����ӡ��Ӧ��
DeviceCapabilities ������������ɻ����һ���豸�������йص���Ϣ
DocumentProperties ��ӡ�����ÿ��ƺ���
EndDocAPI ����һ���ɹ��Ĵ�ӡ��ҵ
EndDocPrinter �ں�̨��ӡ����ļ���ָ��һ���ĵ��Ľ���
EndPage ������������һ��ҳ��Ĵ�ӡ����׼���豸�������Ա��ӡ��һ��ҳ
EndPagePrinter ָ��һ��ҳ�ڴ�ӡ��ҵ�еĽ�β
EnumForms ö��һ̨��ӡ�����õı�
EnumJobs ö�ٴ�ӡ�����е���ҵ
EnumMonitors ö�ٿ��õĴ�ӡ������
EnumPorts ö��һ��ϵͳ���õĶ˿�
EnumPrinterDrivers ö��ָ��ϵͳ���Ѱ�װ�Ĵ�ӡ����������
EnumPrinters ö��ϵͳ�а�װ�Ĵ�ӡ��
EnumPrintProcessorDatatypes ö����һ����ӡ������֧�ֵ���������
EnumPrintProcessors ö��ϵͳ�п��õĴ�ӡ������
Escape �豸���ƺ���
FindClosePrinterChangeNotification �ر���FindFirstPrinterChangeNotification������ȡ��һ����ӡ��ͨ�����
FindFirstPrinterChangeNotification ����һ���µĸı�ͨ������Ա�����ע���ӡ��״̬�ĸ��ֱ仯
FindNextPrinterChangeNotification ����������жϴ���һ�δ�ӡ���ı�ͨ���źŵ�ԭ��
FreePrinterNotifyInfo �ͷ���FindNextPrinterChangeNotification���������һ��������
GetForm ȡ����ָ�����йص���Ϣ
GetJob ��ȡ��ָ����ҵ�йص���Ϣ
GetPrinter ȡ����ָ����ӡ���йص���Ϣ
GetPrinterData Ϊ��ӡ������ע���������Ϣ
GetPrinterDriver ���ָ���Ĵ�ӡ������ȡ���ӡ�����������йص���Ϣ
GetPrinterDriverDirectory �ж�ָ��ϵͳ�а����˴�ӡ�����������Ŀ¼��ʲô
GetPrintProcessorDirectory �ж�ָ��ϵͳ�а����˴�ӡ�����������������ļ���Ŀ¼
OpenPrinter ��ָ���Ĵ�ӡ��������ȡ��ӡ���ľ��
PrinterMessageBox ��ӵ��ָ����ӡ��ҵ��ϵͳ����ʾһ����ӡ��������Ϣ��
PrinterProperties ������ӡ�����ԶԻ����Ա�Դ�ӡ����������
ReadPrinter �Ӵ�ӡ����������
ResetDC ����һ���豸����
ResetPrinter �ı�ָ����ӡ����Ĭ���������ͼ��ĵ�����
ScheduleJob �ύһ��Ҫ��ӡ����ҵ
SetAbortProc ΪWindowsָ��ȡ�������ĵ�ַ
SetForm Ϊָ���ı�������Ϣ
SetJob ��һ����ӡ��ҵ��״̬���п���
SetPrinter ��һ̨��ӡ����״̬���п���
SetPrinterData ���ô�ӡ����ע���������Ϣ
StartDoc ��ʼһ����ӡ��ҵ
StartDocPrinter �ں�̨��ӡ�ļ�������һ�����ĵ�
StartPage ��ӡһ����ҳǰҪ�ȵ����������
StartPagePrinter �ڴ�ӡ��ҵ��ָ��һ����ҳ�Ŀ�ʼ
WritePrinter ������Ŀ¼�е�����д���ӡ��

 

 

 

 
 

 
5. API֮�ı������庯��

AddFontResource ��Windowsϵͳ�����һ��������Դ
CreateFont ��ָ�������Դ���һ���߼�����
CreateFontIndirect ��ָ�������Դ���һ���߼�����
CreateScalableFontResource Ϊһ��TureType���崴��һ����Դ�ļ����Ա�����API����AddFontResource�������Windowsϵͳ
DrawText ���ı���浽ָ���ľ�����
DrawTextEx ��DrawText���ƣ�ֻ�Ǽ����˸���Ĺ���
EnumFontFamilies �о�ָ���豸���õ�����
EnumFontFamiliesEx �о�ָ���豸���õ�����

EnumFonts �о�ָ���豸���õ�����
ExtTextOut ������չ���ı���溯����Ҳ��ο�SetTextAlign����
GetAspectRatioFilterEx ��SetMapperFlagsҪ��Windowsֻѡ�����豸��ǰ�ݺ������Ĺ�դ����ʱ�����������ж��ݺ�ȴ�С
GetCharABCWidths �ж�TureType������һ�������ַ���A-B-C��С
GetCharABCWidthsFloat ��ѯһ��������һ�������ַ���A-B-C�ߴ�
GetCharacterPlacement �ú��������˽������һ���������ַ���ʾһ���ִ�
GetCharWidth ����������һ�������ַ��Ŀ��
GetFontData ����һ�ֿ����������ļ�������
GetFontLanguageInfo ����Ŀǰѡ��ָ���豸�����е��������Ϣ
GetGlyphOutline ȡ��TureType�����й���һ���ַ���������Ϣ
GetKerningPairs ȡ��ָ��������־���Ϣ
GetOutlineTextMetrics ������TureType�����ڲ������йص���ϸ��Ϣ
GetRasterizerCaps �˽�ϵͳ�Ƿ�������֧�ֿ����ŵ�����
GetTabbedTextExtent �ж�һ���ִ�ռ�ݵķ�Χ��ͬʱ�����Ʊ�վ���������
GetTextAlign ����һ���豸������ǰ���ı������־
GetTextCharacterExtra �ж϶����ַ����ĵ�ǰֵ
GetTextCharset ���յ�ǰѡ��ָ���豸������������ַ�����ʶ��
GetTextCharsetInfo ��ȡ�뵱ǰѡ��������ַ����йص���ϸ��Ϣ
GetTextColor �жϵ�ǰ������ɫ��ͨ��Ҳ��Ϊ��ǰ��ɫ��
GetTextExtentExPoint �ж�Ҫ����ָ��������ַ�������Ҳ��һ������װ��ÿ���ַ��ķ�Χ��Ϣ
GetTextExtentPoint �ж�һ���ִ��Ĵ�С����Χ��
GetTextFace ��ȡһ�������������
GetTextMetrics ��ȡ��ѡ��һ���豸���������������йص���Ϣ
GrayString ���һ���Ի�ɫ��ʾ���ִ���ͨ����Windows���ڱ�ʶ��ֹ״̬
PolyTextOut ���һϵ���ִ�
RemoveFontResource ��Windowsϵͳ��ɾ��һ��������Դ
SetMapperFlags Windows���������ӳ��ʱ�����øú���ѡ����Ŀ���豸���ݺ������Ĺ�դ����
SetTextAlign �����ı����뷽ʽ����ָ�����ı����������ʹ���豸�����ĵ�ǰλ��
SetTextCharacterExtra ����ı���ʱ��ָ��Ҫ���ַ������Ķ�����
SetTextColor ���õ�ǰ�ı���ɫ��������ɫҲ��Ϊ��ǰ��ɫ��
SetTextJustification ͨ��ָ��һ���ı���Ӧռ�ݵĶ���ռ䣬��������������ı��������˶��봦��
TabbedTextOut ֧���Ʊ�վ��һ���ı���溯��
TextOut �ı���ͼ����

 

 
 
 
 

6. API֮�˵�����
 

AppendMenu ��ָ���Ĳ˵������һ���˵���
CheckMenuItem ��ѡ������ѡָ���Ĳ˵���Ŀ
CheckMenuRadioItem ָ��һ���˵���Ŀ����ѡ�ɡ���ѡ����Ŀ
CreateMenu �����²˵�
CreatePopupMenu ����һ���յĵ���ʽ�˵�
DeleteMenu ɾ��ָ���Ĳ˵���Ŀ
DestroyMenu ɾ��ָ���Ĳ˵�
DrawMenuBar Ϊָ���Ĵ����ػ��˵�
EnableMenuItem ������ָֹ���Ĳ˵���Ŀ
GetMenu ȡ�ô�����һ���˵��ľ��
GetMenuCheckMarkDimensions ����һ���˵���ѡ���Ĵ�С
GetMenuContextHelpId ȡ��һ���˵��İ�������ID
GetMenuDefaultItem �жϲ˵��е��ĸ���Ŀ��Ĭ����Ŀ
GetMenuItemCount ���ز˵�����Ŀ���˵��������
GetMenuItemID ����λ�ڲ˵���ָ��λ�ô�����Ŀ�Ĳ˵�ID
GetMenuItemInfo ȡ�ã����գ���һ���˵���Ŀ�йص��ض���Ϣ
GetMenuItemRect ��һ��������װ��ָ���˵���Ŀ����Ļ������Ϣ
GetMenuState ȡ����ָ���˵���Ŀ״̬�йص���Ϣ
GetMenuString ȡ��ָ���˵���Ŀ���ִ�
GetSubMenu ȡ��һ������ʽ�˵��ľ������λ�ڲ˵���ָ����λ��
GetSystemMenu ȡ��ָ�����ڵ�ϵͳ�˵��ľ��
HiliteMenuItem ���ƶ����˵���Ŀ�ļ�����ʾ״̬
InsertMenu �ڲ˵���ָ��λ�ô�����һ���˵���Ŀ����������Ҫ��������Ŀ�����ƶ�
InsertMenuItem ����һ���²˵���Ŀ
IsMenu �ж�ָ���ľ���Ƿ�Ϊһ���˵��ľ��
LoadMenu ��ָ����ģ���Ӧ�ó���ʵ��������һ���˵�
LoadMenuIndirect ����һ���˵�
MenuItemFromPoint �ж��ĸ��˵���Ŀ��������Ļ��һ��ָ���ĵ�
ModifyMenu �ı�˵���Ŀ
RemoveMenu ɾ��ָ���Ĳ˵���Ŀ
SetMenu ���ô��ڲ˵�
SetMenuContextHelpId ����һ���˵��İ�������ID
SetMenuDefaultItem ��һ���˵���Ŀ��ΪĬ����Ŀ
SetMenuItemBitmaps ����һ���ض�λͼ��������ָ���Ĳ˵���Ŀ��ʹ�ã������׼�ĸ�ѡ���ţ��̣�
SetMenuItemInfo Ϊһ���˵���Ŀ����ָ������Ϣ
TrackPopupMenu ����Ļ������ط���ʾһ������ʽ�˵�
TrackPopupMenuEx ��TrackPopupMenu���ƣ�ֻ�����ṩ�˶���Ĺ���
7. API֮λͼ��ͼ��͹�դ���㺯��
BitBlt ��һ��λͼ��һ���豸�������Ƶ���һ��
CopyIcon ����ָ��ͼ������ָ���һ��������������������ڷ������õ�Ӧ�ó���
CopyImage ����λͼ��ͼ���ָ�룬ͬʱ�ڸ��ƹ����н���һЩת������
CreateBitmap ���չ涨�ĸ�ʽ����һ�����豸�й�λͼ
CreateBitmapIndirect ����һ�����豸�й�λͼ
CreateCompatibleBitmap ����һ�����豸�й�λͼ������ָ�����豸��������
CreateCursor ����һ�����ָ��
CreateDIBitmap ����һ�����豸�޹ص�λͼ����һ�����豸�йص�λͼ
CreateDIBSection ����һ��DIBSection
CreateIcon ����һ��ͼ��
CreateIconIndirect ����һ��ͼ��
DestroyCursor ���ָ�������ָ�룬���ͷ���ռ�õ�����ϵͳ��Դ
DestroyIcon ���ͼ��
DrawIcon ��ָ����λ�û�һ��ͼ��
DrawIconEx ���һ��ͼ������ָ�롣��DrawIcon��ȣ���������ṩ�˸���Ĺ���
ExtractAssociatedIcon �ж�һ����ִ�г����DLL���Ƿ����ͼ�꣬���Ƿ���ͼ����ϵͳע�����ָ�����ļ����ڹ�������ȡ֮
ExtractIcon �ж�һ����ִ���ļ���DLL���Ƿ���ͼ����ڣ���������ȡ����
GetBitmapBits ������λͼ�Ķ�����λ���Ƶ�һ��������
GetBitmapDimensionEx ȡ��һ��λͼ�Ŀ�Ⱥ͸߶�
GetDIBColorTable ��ѡ���豸������DIBSection��ȡ����ɫ����Ϣ
GetDIBits ������һ��λͼ�Ķ�����λ���Ƶ�һ�����豸�޹ص�λͼ��
GetIconInfo ȡ����ͼ���йص���Ϣ
GetStretchBltMode �ж�StretchBlt �� StretchDIBits�������õ�����ģʽ
LoadBitmap ��ָ����ģ���Ӧ�ó���ʵ��������һ��λͼ
LoadCursor ��ָ����ģ���Ӧ�ó���ʵ��������һ�����ָ��
LoadCursorFromFile ��һ��ָ���ļ���һ������ָ���ļ��Ļ����ϴ���һ��ָ��
LoadIcon ��ָ����ģ���Ӧ�ó���ʵ��������һ��ͼ��
LoadImage ����һ��λͼ��ͼ���ָ��
MaskBlt ִ�и��ӵ�ͼ���䣬ͬʱ������ģ��MASK������
PatBlt �ڵ�ǰѡ����ˢ�ӵĻ����ϣ���һ��ͼ�����ָ�����豸����
PlgBlt ����һ��λͼ��ͬʱ����ת����һ��ƽ���ı��Ρ��������ɶ�λͼ������ת����
SetBitmapBits �����Ի������Ķ�����λ���Ƶ�һ��λͼ
SetBitmapDimensionEx ����һ��λͼ�Ŀ�ȡ���һ���׵�ʮ��֮һΪ��λ
SetDIBColorTable ����ѡ���豸������һ��DIBSection����ɫ����Ϣ
SetDIBits ���������豸�޹�λͼ�Ķ�����λ���Ƶ�һ�����豸�йص�λͼ��
SetDIBitsToDevice ��һ�����豸�޹�λͼ��ȫ���򲿷�����ֱ�Ӹ��Ƶ�һ���豸
SetStretchBltMode ָ��StretchBlt �� StretchDIBits����������ģʽ
StretchBlt ��һ��λͼ��һ���豸�������Ƶ���һ��
StretchDIBits ��һ�����豸�޹�λͼ��ȫ���򲿷�����ֱ�Ӹ��Ƶ�ָ�����豸����

8. API֮��ͼ����
 

AbortPath ����ѡ��ָ���豸�����е�����·����Ҳȡ��Ŀǰ���ڽ��е��κ�·���Ĵ�������
AngleArc ��һ�����ӻ���һ����
Arc ��һ��Բ��
BeginPath ����һ��·����֧
CancelDC ȡ����һ���߳���ĳ�ʱ���ͼ����
Chord ��һ����
CloseEnhMetaFile �ر�ָ������ǿ��ͼԪ�ļ��豸�����������½���ͼԪ�ļ�����һ�����
CloseFigure ��浽һ��·��ʱ���رյ�ǰ�򿪵�ͼ��
CloseMetaFile �ر�ָ����ͼԪ�ļ��豸�����������½���ͼԪ�ļ�����һ�����
CopyEnhMetaFile ����ָ����ǿ��ͼԪ�ļ���һ��������������
CopyMetaFile ����ָ������׼��ͼԪ�ļ���һ������
CreateBrushIndirect ��һ��LOGBRUSH���ݽṹ�Ļ����ϴ���һ��ˢ��
CreateDIBPatternBrush ��һ�����豸�޹ص�λͼ����һ��ˢ�ӣ��Ա�ָ��ˢ����ʽ��ͼ����
CreateEnhMetaFile ����һ����ǿ�͵�ͼԪ�ļ��豸����
CreateHatchBrush ����������Ӱͼ����һ��ˢ��
CreateMetaFile ����һ��ͼԪ�ļ��豸����

CreatePatternBrush ��ָ����ˢ��ͼ����һ��λͼ����һ��ˢ��
CreatePen ��ָ������ʽ����Ⱥ���ɫ����һ������
CreatePenIndirect ����ָ����LOGPEN�ṹ����һ������
CreateSolidBrush �ô�ɫ����һ��ˢ��
DeleteEnhMetaFile ɾ��ָ������ǿ��ͼԪ�ļ�
DeleteMetaFile ɾ��ָ����ͼԪ�ļ�
DeleteObject ɾ��GDI���󣬶���ʹ�õ�����ϵͳ��Դ���ᱻ�ͷ�
DrawEdge ��ָ������ʽ���һ�����εı߿�
DrawEscape ���루Escape������������ֱ�ӷ�����ʾ�豸��������
DrawFocusRect ��һ���������
DrawFrameControl ���һ����׼�ؼ�
DrawState Ϊһ��ͼ����ͼ����Ӧ�ø�ʽ������Ч��
Ellipse ���һ����Բ����ָ���ľ���Χ��
EndPath ֹͣ����һ��·��
EnumEnhMetaFile ���һ����ǿ��ͼԪ�ļ����о����е�����ͼԪ�ļ���¼
EnumMetaFile Ϊһ����׼��windowsͼԪ�ļ�ö�ٵ�����ͼԪ�ļ���¼
EnumObjects ö�ٿ���ָͬ���豸����ʹ�õĻ��ʺ�ˢ��
ExtCreatePen ����һ����չ���ʣ�װ�λ򼸺Σ�
ExtFloodFill ��ָ�����豸������õ�ǰѡ���ˢ�����һ������
FillPath �ر�·�����κδ򿪵�ͼ�Σ����õ�ǰˢ�����
FillRect ��ָ����ˢ�����һ������
FlattenPath ��һ��·���е��������߶�ת�����߶�
FloodFill �õ�ǰѡ����ˢ����ָ�����豸���������һ������
FrameRect ��ָ����ˢ��Χ��һ�����λ�һ���߿�
GdiComment Ϊָ������ǿ��ͼԪ�ļ��豸�������һ��ע����Ϣ
GdiFlush ִ���κ�δ���Ļ�ͼ����
GdiGetBatchLimit �ж��ж��ٸ�GDI��ͼ����λ�ڶ�����
GdiSetBatchLimit ָ���ж��ٸ�GDI��ͼ�����ܹ��������
GetArcDirection ��Բ����ʱ���жϵ�ǰ���õĻ�ͼ����
GetBkColor ȡ��ָ���豸������ǰ�ı�����ɫ
GetBkMode ���ָ�����豸������ȡ�õ�ǰ�ı������ģʽ
GetBrushOrgEx �ж�ָ���豸�����е�ǰѡ��ˢ�����
GetCurrentObject ���ָ�����͵ĵ�ǰѡ������
GetCurrentPositionEx ��ָ�����豸������ȡ�õ�ǰ�Ļ���λ��
GetEnhMetaFile ȡ�ô����ļ��а�����һ����ǿ��ͼԪ�ļ���ͼԪ�ļ����

 

 

 
 

9. API֮�豸��������
 

CombineRgn �������������Ϊһ��������
CombineTransform ��������ת�������൱����˳���������ת��
CreateCompatibleDC ����һ�����ض��豸����һ�µ��ڴ��豸����
CreateDC Ϊר���豸�����豸����
CreateEllipticRgn ����һ����Բ
CreateEllipticRgnIndirect ����һ���������ض����ε���Բ����
CreateIC Ϊר���豸����һ����Ϣ����
CreatePolygonRgn ����һ����һϵ�е�Χ�ɵ�����
CreatePolyPolygonRgn �����ɶ������ι��ɵ�����ÿ������ζ�Ӧ�Ƿ�յ�
CreateRectRgn ����һ����������
CreateRectRgnIndirect ����һ����������
CreateRoundRectRgn ����һ��Բ�Ǿ���
DeleteDC ɾ��ר���豸��������Ϣ�������ͷ�������ش�����Դ
DPtoLP ��������豸����ת����ר���豸�����߼�����
EqualRgn ȷ�����������Ƿ����
ExcludeClipRect ��ר���豸�����ļ�������ȥ��һ���������������ڲ��ܽ��л�ͼ
ExcludeUpdateRgn ��ר���豸����������ȥ��ָ�����ڵ�ˢ������
ExtCreateRegion ��������ת���޸�����
ExtSelectClipRgn ��ָ��������ϵ��豸�����ĵ�ǰ������
FillRgn ��ָ��ˢ�����ָ������
FrameRgn ��ָ��ˢ��Χ��ָ������һ�����
GetBoundsRect ��ȡָ���豸�����ı߽����
GetClipBox ��ȡ��ȫ����ָ���豸��������������С����
GetClipRgn ��ȡ�豸������ǰ������
GetDC ��ȡָ�����ڵ��豸����
GetDCEx Ϊָ�����ڻ�ȡ�豸���������GetDC���������ṩ�˸����ѡ��
GetDCOrgEx ��ȡָ���豸�������λ�ã�����Ļ�����ʾ��
GetDeviceCaps ����ָ���豸����������豸�Ĺ��ܷ�����Ϣ
GetGraphicsMode ȷ���Ƿ�������ǿͼ��ģʽ������ת����
GetMapMode Ϊ�ض��豸��������ӳ��ģʽ
GetRegionData װ������һ��������Ϣ��RgnData�ṹ�򻺳���
GetRgnBox ��ȡ��ȫ����ָ���������С����
GetUpdateRgn ȷ��ָ�����ڵ�ˢ�����򡣸�����ǰ��Ч����Ҫˢ��
GetViewportExtEx ��ȡ�豸�����ӿڣ�viewport����Χ
GetViewportOrgEx ��ȡ�豸�����ӿ����
GetWindowDC ��ȡ�������ڣ������߿򡢹����������������˵��ȣ����豸����
GetWindowExtEx ��ȡָ���豸�����Ĵ��ڷ�Χ
GetWindowOrgEx ��ȡָ���豸�������߼����ڵ����
GetWindowRgn ��ȡ��������
GetWorldTransform ���������ת����Ϊ�豸������ȡ��ǰ����ת��
IntersectClipRect Ϊָ���豸����һ���µļ�����
InvalidateRgn ʹ����ָ�����򲻻�����������봰��ˢ������ʹ֮������ػ�
InvertRgn ͨ���ߵ�ÿ������ֵ��ת�豸����ָ������
LPtoDP �������ָ���豸�����߼�����ת��Ϊ�豸����
ModifyWorldTransform ����ָ����ģʽ�޸�����ת��
OffsetClipRgn ��ָ����ƽ���豸����������
OffsetRgn ��ָ��ƫ����ƽ��ָ������
OffsetViewportOrgEx ƽ���豸�����ӿ�����
OffsetWindowOrgEx ƽ��ָ���豸�����������
PaintRgn �õ�ǰˢ�ӱ���ɫ���ָ������
PtInRegion ȷ�����Ƿ���ָ��������
PtVisible ȷ��ָ�����Ƿ�ɼ����������Ƿ����豸�����������ڣ�
RectInRegion ȷ�������Ƿ��в�����ָ��������
RectVisible ȷ��ָ�������Ƿ��в��ֿɼ����Ƿ����豸�����������ڣ�
ReleaseDC �ͷ��ɵ���GetDC��GetWindowDC������ȡ��ָ���豸����
RestoreDC ���豸������ջ�ָ�һ��ԭ�ȱ�����豸����
SaveDC ��ָ���豸����״̬���浽Windows�豸������ջ
ScaleViewportExtEx �����豸�����ӿڵķ�Χ
ScaleWindowExtEx ����ָ���豸�������ڷ�Χ
ScrollDC �ڴ��ڣ����豸����������ˮƽ�ͣ��򣩴�ֱ��������
SelectClipRgn Ϊָ���豸����ѡ���µļ�����
SetBoundsRect ����ָ���豸�����ı߽����
SetGraphicsMode ������ֹ��ǿͼ��ģʽ�����ṩĳЩ֧�֣���������ת����
SetMapMode ����ָ���豸������ӳ��ģʽ
SetRectRgn ��������Ϊָ���ľ���
SetViewportExtEx �����豸�����ӿڷ�Χ
SetViewportOrgEx �����豸�����ӿ����
SetWindowExtEx ����ָ���豸�������ڷ�Χ
SetWindowOrgEx ����ָ���豸�����������
SetWindowRgn ���ô�������
SetWorldTransform ��������ת��
ValidateRgn �������ָ�����򣬰�����ˢ��������
WindowFromDC ȡ����ĳһ�豸������صĴ��ڵľ��

 

 
GetEnhMetaFileBits ��ָ������ǿ��ͼԪ�ļ����Ƶ�һ���ڴ滺������
GetEnhMetaFileDescription ���ض�һ����ǿ��ͼԪ�ļ���˵��
GetEnhMetaFileHeader ȡ����ǿ��ͼԪ�ļ���ͼԪ�ļ�ͷ
GetEnhMetaFilePaletteEntries ȡ����ǿ��ͼԪ�ļ���ȫ���򲿷ֵ�ɫ��
GetMetaFile ȡ�ð�����һ�������ļ��е�ͼԪ�ļ���ͼԪ�ļ����
GetMetaFileBitsEx ��ָ����ͼԪ�ļ����Ƶ�һ���ڴ滺����
GetMiterLimit ȡ���豸������б�����ƣ�Miter������
GetNearestColor �����豸����ʾ������ȡ����ָ����ɫ��ӽ���һ�ִ�ɫ
GetObjectAPI ȡ�ö�ָ���������˵����һ���ṹ
GetObjectType �ж���ָ��������õ�GDI���������
GetPath ȡ�öԵ�ǰ·�����ж����һϵ������
GetPixel ��ָ�����豸������ȡ��һ�����ص�RGBֵ
GetPolyFillMode ���ָ�����豸��������ö�������ģʽ
GetROP2 ���ָ�����豸������ȡ�õ�ǰ�Ļ�ͼģʽ
GetStockObject ȡ��һ�����ж���Stock��
GetSysColorBrush Ϊ�κ�һ�ֱ�׼ϵͳ��ɫȡ��һ��ˢ��
GetWinMetaFileBits ͨ����һ����������������ڱ�׼ͼԪ�ļ������ݣ���һ����ǿ��ͼԪ�ļ�ת���ɱ�׼windowsͼԪ�ļ�
InvertRect ͨ����תÿ�����ص�ֵ���Ӷ���תһ���豸������ָ���ľ���
LineDDA ö��ָ���߶��е����е�
LineTo �õ�ǰ���ʻ�һ���ߣ��ӵ�ǰλ������һ��ָ���ĵ�
MoveToEx Ϊָ�����豸����ָ��һ���µĵ�ǰ����λ��
PaintDesk ��ָ�����豸�������������ǽֽͼ��
PathToRegion ����ǰѡ����·��ת����һ��������

PlayEnhMetaFile ��ָ�����豸�����л�һ����ǿ��ͼԪ�ļ�
PlayEnhMetaFileRecord �طŵ���һ����ǿ��ͼԪ�ļ���¼
PlayMetaFile ��ָ�����豸�����лط�һ��ͼԪ�ļ�
PlayMetaFileRecord �ط�����ͼԪ�ļ��ĵ�����¼
PolyBezier ���һ���������������Bezier������
PolyDraw ���һ�����ӵ����ߣ����߶μ��������������
Polygon ���һ�������
Polyline �õ�ǰ�������һϵ���߶�
PolyPolygon �õ�ǰѡ����������������������
PolyPolyline �õ�ǰѡ����������������������
Rectangle �õ�ǰѡ���Ļ��������Σ����õ�ǰѡ����ˢ�����
RoundRect �õ�ǰѡ���Ļ��ʻ�һ��Բ�Ǿ��Σ����õ�ǰѡ����ˢ�����������
SelectClipPath ���豸������ǰ��·���ϲ�������������
SelectObject Ϊ��ǰ�豸����ѡ��ͼ�ζ���
SetArcDirection ����Բ������淽��
SetBkColor Ϊָ�����豸�������ñ�����ɫ
SetBkMode ָ����Ӱˢ�ӡ����߻����Լ��ַ��еĿ�϶����䷽ʽ
SetBrushOrgEx Ϊָ�����豸�������õ�ǰѡ��ˢ�ӵ����
SetEnhMetaFileBits ��ָ���ڴ滺�����ڰ��������ݴ���һ����ǿ��ͼԪ�ļ�
SetMetaFileBitsEx �ð�����ָ���ڴ滺�����ڵ����ݽṹ����һ��ͼԪ�ļ�
SetMiterLimit �����豸������ǰ��б������
SetPixel ��ָ�����豸����������һ�����ص�RGBֵ
SetPixelV ��ָ�����豸����������һ�����ص�RGBֵ
SetPolyFillMode ���ö���ε����ģʽ
SetROP2 ����ָ���豸�����Ļ�ͼģʽ����vb��DrawMode������ȫһ��
SetWinMetaFileBits ��һ����׼WindowsͼԪ�ļ�ת������ǿ��ͼԪ�ļ�
StrokeAndFillPath ���ָ�����豸�������ر�·���ϴ򿪵���������
StrokePath �õ�ǰ�������һ��·�����������򿪵�ͼ�β��ᱻ��������ر�
UnrealizeObject ��һ��ˢ�Ӷ���ѡ���豸����֮ǰ����ˢ�ӵ����׼����SetBrushOrgEx�޸ģ�������ȵ��ñ�����
WidenPath ����ѡ�����ʵĿ�ȣ����¶��嵱ǰѡ����·��

 

 
10. API֮Ӳ����ϵͳ����
ActivateKeyboardLayout ����һ���µļ��̲��֡����̲��ֶ����˰�����һ�������Լ����ϵ�λ���뺬��
Beep �������ɼ򵥵�����
CharToOem ��һ���ִ���ANSI�ַ���ת����OEM�ַ���
ClipCursor ��ָ�����Ƶ�ָ������
ConvertDefaultLocale ��һ������ĵط���ʶ��ת������ʵ�ĵط�ID
CreateCaret ����ָ������Ϣ����һ�����������꣩��������ѡ��Ϊָ�����ڵ�Ĭ�ϲ����
DestroyCaret ������ƻ���һ�������
EnumCalendarInfo ö����ָ�����ط��������п��õ�������Ϣ
EnumDateFormats �о�ָ���ġ����ء������п��õĳ��������ڸ�ʽ
EnumSystemCodePages ö��ϵͳ���Ѱ�װ��֧�ֵĴ���ҳ
EnumSystemLocales ö��ϵͳ�Ѿ���װ���ṩ֧�ֵġ��ط�������
EnumTimeFormats ö��һ��ָ���ĵط����õ�ʱ���ʽ
ExitWindowsEx �˳�windows�������ض���ѡ����������
ExpandEnvironmentStrings ���价���ִ�
FreeEnvironmentStrings ����ָ���Ļ����ִ���
GetACP �ж�Ŀǰ������Ч��ANSI����ҳ
GetAsyncKeyState �жϺ�������ʱָ���������״̬
GetCaretBlinkTime �жϲ����������˸Ƶ��
GetCaretPos �жϲ�����ĵ�ǰλ��
GetClipCursor ȡ��һ�����Σ���������ĿǰΪ���ָ��涨�ļ�������
GetCommandLine ���ָ��ǰ�����л�������һ��ָ��
GetComputerName ȡ����̨�����������
GetCPInfo ȡ����ָ������ҳ�йص���Ϣ
GetCurrencyFormat ���ָ���ġ��ط������ã����ݻ��Ҹ�ʽ��ʽ��һ������
GetCursor ��ȡĿǰѡ������ָ��ľ��
GetCursorPos ��ȡ���ָ��ĵ�ǰλ��
GetDateFormat ���ָ���ġ����ء���ʽ����һ��ϵͳ���ڽ��и�ʽ��
GetDoubleClickTime �ж�����������굥��֮��ᱻ�����˫���¼��ļ��ʱ��
GetEnvironmentStrings Ϊ�����˵�ǰ�����ִ����õ�һ���ڴ�����ͷ���һ�����
GetEnvironmentVariable ȡ��һ������������ֵ
GetInputState �ж��Ƿ�����κδ������ȴ���������������¼�
GetKBCodePage ��GetOEMCPȡ�������߹�����ȫ��ͬ
GetKeyboardLayout ȡ��һ�����������ָ��Ӧ�ó���ļ��̲���
GetKeyboardLayoutList ���ϵͳ���õ����м��̲��ֵ�һ���б�
GetKeyboardLayoutName ȡ�õ�ǰ����̲��ֵ�����
GetKeyboardState ȡ�ü�����ÿ���������ǰ��״̬
GetKeyboardType �˽�������ʹ�õļ����йص���Ϣ
GetKeyNameText �ڸ���ɨ�����ǰ���£��жϼ���
GetKeyState ����Ѵ�����İ����������һ��������Ϣʱ���ж�ָ���������״̬
GetLastError ���֮ǰ���õ�api���������������ȡ����չ������Ϣ
GetLocaleInfo ȡ����ָ�����ط����йص���Ϣ
GetLocalTime ȡ�ñ������ں�ʱ��
GetNumberFormat ���ָ���ġ��ط��������ض��ĸ�ʽ��ʽ��һ������
GetOEMCP �ж���OEM��ANSI�ַ�����ת����windows����ҳ
GetQueueStatus �ж�Ӧ�ó�����Ϣ�����д������ȴ���������Ϣ����
GetSysColor �ж�ָ��windows��ʾ�������ɫ
GetSystemDefaultLangID ȡ��ϵͳ��Ĭ������ID
GetSystemDefaultLCID ȡ�õ�ǰ��Ĭ��ϵͳ���ط���
GetSystemInfo ȡ����ײ�Ӳ��ƽ̨�йص���Ϣ11. API֮���̺��̺߳���

CancelWaitableTimer �����������ȡ��һ�����Եȴ���ȥ�ļ�ʱ������
CallNamedPipe ���������һ��ϣ��ͨ���ܵ�ͨ�ŵ�һ���ͻ����̵���
ConnectNamedPipe ָʾһ̨�������ȴ���ȥ��ֱ���ͻ���ͬһ�������ܵ�����
CreateEvent ����һ���¼�����
CreateMailslot ����һ����·�����صľ������·������ʹ�ã��ռ��ˣ�
CreateMutex ����һ�������壨MUTEX��
CreateNamedPipe ����һ�������ܵ������صľ���ɹܵ��ķ�������ʹ��
CreatePipe ����һ�������ܵ�
CreateProcess ����һ���½��̣�����ִ��һ������
CreateSemaphore ����һ���µ��źŻ�
CreateWaitableTimer ����һ���ɵȴ��ļ�ʱ������
DisconnectNamedPipe �Ͽ�һ���ͻ���һ�������ܵ�������
DuplicateHandle ��ָ��һ������ϵͳ����ǰ���������£�Ϊ�Ǹ����󴴽�һ���¾��
ExitProcess ��ֹһ������
FindCloseChangeNotification �ر�һ���Ķ�֪ͨ����
FindExecutable ������һ��ָ���ļ�������һ��ĳ�����ļ���
FindFirstChangeNotification ����һ���ļ�֪ͨ���󡣸ö������ڼ����ļ�ϵͳ�����ı仯
FindNextChangeNotification ����һ���ļ��ı�֪ͨ�����������������һ�α仯
FreeLibrary �ͷ�ָ���Ķ�̬���ӿ�
GetCurrentProcess ��ȡ��ǰ���̵�һ��α���
GetCurrentProcessId ��ȡ��ǰ����һ��Ψһ�ı�ʶ��
GetCurrentThread ��ȡ��ǰ�̵߳�һ��α���
GetCurrentThreadId ��ȡ��ǰ�߳�һ��Ψһ���̱߳�ʶ��
GetExitCodeProces ��ȡһ�����жϽ��̵��˳�����
GetExitCodeThread ��ȡһ������ֹ�̵߳��˳�����
GetHandleInformation ��ȡ��һ��ϵͳ�������йص���Ϣ
GetMailslotInfo ��ȡ��һ����·�йص���Ϣ
GetModuleFileName ��ȡһ����װ��ģ�������·������
GetModuleHandle ��ȡһ��Ӧ�ó����̬���ӿ��ģ����
GetPriorityClass ��ȡ�ض����̵����ȼ���
GetProcessShutdownParameters ����ϵͳ�ر�ʱһ��ָ���Ľ���������������̵Ĺر�������
GetProcessTimes ��ȡ��һ�����̵ľ���ʱ���йص���Ϣ
GetProcessWorkingSetSize �˽�һ��Ӧ�ó��������й�����ʵ�����������˶���������ڴ�
GetSartupInfo ��ȡһ�����̵�������Ϣ
GetThreadPriority ��ȡ�ض��̵߳����ȼ���
GetTheardTimes ��ȡ��һ���̵߳ľ���ʱ���йص���Ϣ
GetWindowThreadProcessId ��ȡ��ָ�����ڹ�����һ���һ�����̺��̱߳�ʶ��
LoadLibrary ����ָ���Ķ�̬���ӿ⣬������ӳ�䵽��ǰ����ʹ�õĵ�ַ�ռ�
LoadLibraryEx װ��ָ���Ķ�̬���ӿ⣬��Ϊ��ǰ���̰���ӳ�䵽��ַ�ռ�
LoadModule ����һ��WindowsӦ�ó��򣬲���ָ���Ļ���������
MsgWaitForMultipleObjects �Ⱥ�������һϵ�ж��󷢳��źš��緵�������Ѿ����㣬����������
SetPriorityClass ����һ�����̵����ȼ���
SetProcessShutdownParameters ��ϵͳ�ر��ڼ䣬Ϊָ�������������������������Ĺر�˳��

SetProcessWorkingSetSize ���ò���ϵͳʵ�ʻ��ָ�����ʹ�õ��ڴ�����
SetThreadPriority �趨�̵߳����ȼ���
ShellExecute ������ָ���ļ�������һ��ĳ�����ļ���
TerminateProcess ����һ������
WinExec ����ָ���ĳ���

 

 
 
 

GetSystemMetrics ������windows�����йص���Ϣ
GetSystemPowerStatus ����뵱ǰϵͳ��Դ״̬�йص���Ϣ
GetSystemTime ȡ�õ�ǰϵͳʱ�䣬���ʱ����õ��ǡ�Эͬ����ʱ�䡱����UTC��Ҳ����GMT����ʽ
GetSystemTimeAdjustment ʹ�ڲ�ϵͳʱ����һ���ⲿ��ʱ���ź�Դͬ��
GetThreadLocale ȡ�õ�ǰ�̵߳ĵط�ID
GetTickCount ���ڻ�ȡ��windows��������������ʱ�䳤�ȣ����룩
GetTimeFormat ��Ե�ǰָ���ġ��ط��������ض��ĸ�ʽ��ʽ��һ��ϵͳʱ��
GetTimeZoneInformation ȡ����ϵͳʱ�������йص���Ϣ
GetUserDefaultLangID Ϊ��ǰ�û�ȡ��Ĭ������ID
GetUserDefaultLCID ȡ�õ�ǰ�û���Ĭ�ϡ��ط�������
GetUserName ȡ�õ�ǰ�û�������
GetVersion �жϵ�ǰ���е�Windows��DOS�汾
GetVersionEx ȡ����ƽ̨�Ͳ���ϵͳ�йصİ汾��Ϣ
HideCaret ��ָ���Ĵ������ز��������꣩
IsValidCodePage �ж�һ������ҳ�Ƿ���Ч
IsValidLocale �жϵط���ʶ���Ƿ���Ч
keybd_event �������ģ���˼����ж�
LoadKeyboardLayout ����һ�����̲���
MapVirtualKey ����ָ����ӳ�����ͣ�ִ�в�ͬ��ɨ������ַ�ת��
MapVirtualKeyEx ����ָ����ӳ�����ͣ�ִ�в�ͬ��ɨ������ַ�ת��
MessageBeep ����һ��ϵͳ������ϵͳ�����ķ��䷽�����ڿ�������������
mouse_event ģ��һ������¼�
OemKeyScan �ж�OEM�ַ����е�һ��ASCII�ַ���ɨ�����Shift��״̬
OemToChar ��OEM�ַ�����һ���ִ�ת����ANSI�ַ���
SetCaretBlinkTime ָ�����������꣩����˸Ƶ��
SetCaretPos ָ���������λ��
SetComputerName �����µļ������
SetCursor ��ָ�������ָ����Ϊ��ǰָ��
SetCursorPos ����ָ���λ��
SetDoubleClickTime ��������������굥��֮����ʹϵͳ��Ϊ��˫���¼��ļ��ʱ��
SetEnvironmentVariable ��һ������������Ϊָ����ֵ
SetKeyboardState ����ÿ���������ǰ�ڼ����ϵ�״̬
SetLocaleInfo �ı��û����ط���������Ϣ
SetLocalTime ���õ�ǰ�ط�ʱ��
SetSysColors ����ָ��������ʾ�������ɫ
SetSystemCursor �ı��κ�һ����׼ϵͳָ��
SetSystemTime ���õ�ǰϵͳʱ��
SetSystemTimeAdjustment ��ʱ���һ��У׼ֵʹ�ڲ�ϵͳʱ����һ���ⲿ��ʱ���ź�Դͬ��
SetThreadLocale Ϊ��ǰ�߳����õط�
SetTimeZoneInformation ����ϵͳʱ����Ϣ
ShowCaret ��ָ���Ĵ�������ʾ���������꣩
ShowCursor �������ָ��Ŀ�����
SwapMouseButton �����Ƿ񻥻�������Ҽ��Ĺ���
SystemParametersInfo ��ȡ�����������ڶ��windowsϵͳ����
SystemTimeToTzSpecificLocalTime ��ϵͳʱ��ת���ɵط�ʱ��
ToAscii ���ݵ�ǰ��ɨ����ͼ�����Ϣ����һ�������ת����ASCII�ַ�
ToUnicode ���ݵ�ǰ��ɨ����ͼ�����Ϣ����һ�������ת����Unicode�ַ�
UnloadKeyboardLayout ж��ָ���ļ��̲���
VkKeyScan ���Windows�ַ�����һ��ASCII�ַ����ж���������Shift����״̬
12. API֮�ؼ�����Ϣ����
 

AdjustWindowRect ����һ�ִ�����ʽ��������Ŀ��ͻ�����������Ĵ��ڴ�С
AnyPopup �ж���Ļ���Ƿ�����κε���ʽ����
ArrangeIconicWindows ����һ�������ڵ���С���Ӵ���
AttachThreadInput �����߳����뺯��
BeginDeferWindowPos ��������һϵ���´���λ�õĹ���
BringWindowToTop ��ָ���Ĵ��ڴ��������б���
CascadeWindows �Բ����ʽ���д���
ChildWindowFromPoint ���ظ������а�����ָ����ĵ�һ���Ӵ��ڵľ��
ClientToScreen �жϴ������Կͻ��������ʾ��һ�������Ļ����
CloseWindow ��С��ָ���Ĵ���
CopyRect �������ݸ���
DeferWindowPos �ú���Ϊ�ض��Ĵ���ָ��һ���´���λ��
DestroyWindow ���ָ���Ĵ����Լ����������Ӵ���
DrawAnimatedRects ���һϵ�ж�̬����
EnableWindow ָ���Ĵ�����������ֹ������꼰��������
EndDeferWindowPos ͬʱ����DeferWindowPos����ʱָ�������д��ڵ�λ�ü�״̬
EnumChildWindows Ϊָ���ĸ�����ö���Ӵ���
EnumThreadWindows ö����ָ��������صĴ���
EnumWindows ö�ٴ����б��е����и�����
EqualRect �ж��������νṹ�Ƿ���ͬ
FindWindow Ѱ�Ҵ����б��е�һ������ָ�������Ķ�������
FindWindowEx �ڴ����б���Ѱ����ָ����������ĵ�һ���Ӵ���
FlashWindow ��˸��ʾָ������
GetActiveWindow ��û���ڵľ��
GetCapture ���һ�����ڵľ�����������λ�ڵ�ǰ�����̣߳���ӵ����겶������������գ�
GetClassInfo ȡ��WNDCLASS�ṹ����WNDCLASSEX�ṹ����һ���������ṹ�а�������ָ�����йص���Ϣ
GetClassLong ȡ�ô������һ��Long������Ŀ
GetClassName Ϊָ���Ĵ���ȡ������
GetClassWord Ϊ������ȡ��һ����������
GetClientRect ����ָ�����ڿͻ������εĴ�С
GetDesktopWindow ��ô���������Ļ��һ�����ڣ����洰�ڣ����
GetFocus ���ӵ�����뽹��Ĵ��ڵľ��
GetForegroundWindow ���ǰ̨���ڵľ��
GetLastActivePopup �����һ�����������������������ĵ���ʽ���ڵľ��
GetParent �ж�ָ�����ڵĸ�����
GetTopWindow �����ڲ������б�Ѱ��������ָ�����ڵ�ͷһ�����ڵľ��
GetUpdateRect ���һ�����Σ���������ָ����������Ҫ���µ���һ����
GetWindow ���һ�����ڵľ�����ô�����ĳԴ�������ض��Ĺ�ϵ
GetWindowContextHelpId ȡ���봰�ڹ�����һ��İ�������ID
GetWindowLong ��ָ�����ڵĽṹ��ȡ����Ϣ
GetWindowPlacement ���ָ�����ڵ�״̬��λ����Ϣ
GetWindowRect ����������ڵķ�Χ���Σ����ڵı߿򡢱����������������˵��ȶ������������


}
