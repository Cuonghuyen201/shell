curl https://upload.wikimedia.org/wikipedia/commons/2/26/You_Have_Been_Hacked%21.jpg -o "$env:USERPROFILE\Desktop\Wallpaper.jpg"
$setwallpapersrc = @"
using System.Runtime.InteropServices;

public class Wallpaper
{
    public const int SetDesktopWallpaper = 20;
    public const int UpdateIniFile = 0x01;
    public const int SendWinIniChange = 0x02;

    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    public static void SetWallpaper(string path)
    {
        SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
    }
}
"@

Add-Type -TypeDefinition $setwallpapersrc -Language CSharp
$wallpaperPath = "$env:USERPROFILE\Desktop\Wallpaper.jpg"
[Wallpaper]::SetWallpaper($wallpaperPath)

Start-Sleep -Milliseconds 5000

for ($i = 1; $i -le 10; $i++) {
    Start-Sleep -Milliseconds 5000
    start microsoft-edge:https://commons.wikimedia.org/wiki/File:You_Have_Been_Hacked!.jpg
}
