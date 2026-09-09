#Requires -RunAsAdministrator
# ============================================================
# ✨ MIDAS WINDOWS UTILITY v3.0 - Liquid Gold Edition
# Author: Alex Z. Fernandez
# ============================================================

# ── 1. Admin Verification ──
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    [System.Windows.Forms.MessageBox]::Show(
        "MIDAS requires Administrator privileges.`n`nPlease re-open PowerShell as Administrator and run the command again.",
        "MIDAS - Admin Access Required",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    ) | Out-Null
    exit
}

# ── 2. Load WPF Assemblies ──
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ============================================================
# XAML GUI DEFINITION (Liquid Gold Theme + Animation)
# ============================================================
[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="✨ MIDAS - Liquid Gold Windows Utility"
    Height="750" Width="1100"
    WindowStartupLocation="CenterScreen"
    Foreground="#FFF8DC"
    ResizeMode="CanResizeWithGrip">

    <Window.Resources>
        <!-- Gold Glow Filter -->
        <DropShadowEffect x:Key="GoldGlow" Color="#FFD700" BlurRadius="12" ShadowDepth="0" Opacity="0.6"/>
        <DropShadowEffect x:Key="ButtonGlow" Color="#DAA520" BlurRadius="8" ShadowDepth="0" Opacity="0.5"/>

        <!-- Modern Gold Button Style -->
        <Style x:Key="GoldButton" TargetType="Button">
            <Setter Property="Background">
                <Setter.Value>
                    <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                        <GradientStop Color="#2A2415" Offset="0"/>
                        <GradientStop Color="#1A160D" Offset="1"/>
                    </LinearGradientBrush>
                </Setter.Value>
            </Setter>
            <Setter Property="Foreground" Value="#FFD700"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="Margin" Value="4"/>
            <Setter Property="BorderBrush" Value="#B8860B"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background">
                                    <Setter.Value>
                                        <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                                            <GradientStop Color="#4A3B10" Offset="0"/>
                                            <GradientStop Color="#2A2415" Offset="1"/>
                                        </LinearGradientBrush>
                                    </Setter.Value>
                                </Setter>
                                <Setter TargetName="border" Property="BorderBrush" Value="#FFD700"/>
                                <Setter Property="Effect" Value="{StaticResource ButtonGlow}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#FFD700"/>
                                <Setter Property="Foreground" Value="#000000"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Accent Gold Action Button -->
        <Style x:Key="AccentGoldButton" TargetType="Button" BasedOn="{StaticResource GoldButton}">
            <Setter Property="Background">
                <Setter.Value>
                    <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                        <GradientStop Color="#FFD700" Offset="0"/>
                        <GradientStop Color="#B8860B" Offset="1"/>
                    </LinearGradientBrush>
                </Setter.Value>
            </Setter>
            <Setter Property="Foreground" Value="#0C0B08"/>
            <Setter Property="BorderBrush" Value="#FFF8DC"/>
            <Setter Property="Effect" Value="{StaticResource GoldGlow}"/>
        </Style>

        <!-- CheckBox Styling -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#EEE8AA"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="Margin" Value="6,5"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>

        <!-- Custom Tab Styling -->
        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#14110B"/>
            <Setter Property="Foreground" Value="#B8860B"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="18,10"/>
            <Setter Property="Margin" Value="2,0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="{TemplateBinding Background}"
                                BorderBrush="#5E4B14" BorderThickness="1,1,1,0"
                                CornerRadius="8,8,0,0" Padding="{TemplateBinding Padding}">
                            <ContentPresenter ContentSource="Header" HorizontalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="tabBorder" Property="Background">
                                    <Setter.Value>
                                        <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
                                            <GradientStop Color="#382C0C" Offset="0"/>
                                            <GradientStop Color="#1A150B" Offset="1"/>
                                        </LinearGradientBrush>
                                    </Setter.Value>
                                </Setter>
                                <Setter Property="Foreground" Value="#FFD700"/>
                                <Setter TargetName="tabBorder" Property="BorderBrush" Value="#FFD700"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <!-- Liquid Gold Background Grid -->
    <Grid x:Name="MainGrid">
        <Grid.Background>
            <LinearGradientBrush x:Name="LiquidGoldBrush" StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#090805" Offset="0.0"/>
                <GradientStop Color="#1A150B" Offset="0.25"/>
                <GradientStop Color="#3A2E0D" Offset="0.5"/>
                <GradientStop Color="#1A150B" Offset="0.75"/>
                <GradientStop Color="#090805" Offset="1.0"/>
                <LinearGradientBrush.RelativeTransform>
                    <RotateTransform x:Name="GoldRotateTransform" CenterX="0.5" CenterY="0.5" Angle="0"/>
                </LinearGradientBrush.RelativeTransform>
            </LinearGradientBrush>
        </Grid.Background>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- HEADER -->
        <Border Grid.Row="0" Background="#120E07" BorderBrush="#8B6508" BorderThickness="0,0,0,2" Padding="20,14">
            <Grid>
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="✨ MIDAS" FontSize="26" FontWeight="Black" Foreground="#FFD700" Effect="{StaticResource GoldGlow}"/>
                    <TextBlock Text=" | The Golden Touch Utility" FontSize="14" Foreground="#DAA520" VerticalAlignment="Center" Margin="10,4,0,0" FontWeight="SemiBold"/>
                </StackPanel>
                <TextBlock Text="v3.0 - Live Edition" FontSize="12" Foreground="#8B6508" HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <!-- MAIN TAB SYSTEM -->
        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="12">

            <!-- TAB 1: INSTALL APPS -->
            <TabItem Header="📦 App Installer">
                <Border Background="#120E07" CornerRadius="0,8,8,8" BorderBrush="#5E4B14" BorderThickness="1" Padding="15">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>

                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>

                                <!-- Browsers -->
                                <StackPanel Grid.Column="0" Margin="5">
                                    <TextBlock Text="🌐 Browsers" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                                    <CheckBox x:Name="chkFirefox" Content="Mozilla Firefox"/>
                                    <CheckBox x:Name="chkBrave" Content="Brave Browser"/>
                                    <CheckBox x:Name="chkEdge" Content="Microsoft Edge"/>
                                    <CheckBox x:Name="chkOperaGX" Content="Opera GX"/>

                                    <TextBlock Text="💬 Social &amp; Chat" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,15,5,10"/>
                                    <CheckBox x:Name="chkDiscord" Content="Discord"/>
                                    <CheckBox x:Name="chkTelegram" Content="Telegram"/>
                                    <CheckBox x:Name="chkWhatsApp" Content="WhatsApp"/>
                                    <CheckBox x:Name="chkZoom" Content="Zoom"/>
                                </StackPanel>

                                <!-- Dev Tools -->
                                <StackPanel Grid.Column="1" Margin="5">
                                    <TextBlock Text="💻 Developer Tools" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="chkVSCode" Content="VS Code"/>
                                    <CheckBox x:Name="chkGit" Content="Git"/>
                                    <CheckBox x:Name="chkNodeJS" Content="Node.js LTS"/>
                                    <CheckBox x:Name="chkPython" Content="Python 3.12"/>
                                    <CheckBox x:Name="chkTerminal" Content="Windows Terminal"/>
                                    <CheckBox x:Name="chkPowerShell7" Content="PowerShell 7"/>
                                    <CheckBox x:Name="chkDocker" Content="Docker Desktop"/>
                                    <CheckBox x:Name="chkNotepadPP" Content="Notepad++"/>
                                </StackPanel>

                                <!-- Media -->
                                <StackPanel Grid.Column="2" Margin="5">
                                    <TextBlock Text="🎬 Media &amp; Design" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="chkVLC" Content="VLC Media Player"/>
                                    <CheckBox x:Name="chkSpotify" Content="Spotify"/>
                                    <CheckBox x:Name="chkOBS" Content="OBS Studio"/>
                                    <CheckBox x:Name="chkGIMP" Content="GIMP Image Editor"/>
                                    <CheckBox x:Name="chkShareX" Content="ShareX Screenshot"/>
                                    <CheckBox x:Name="chkHandbrake" Content="Handbrake Video Converter"/>
                                </StackPanel>

                                <!-- Utilities -->
                                <StackPanel Grid.Column="3" Margin="5">
                                    <TextBlock Text="🔧 System Tools" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                                    <CheckBox x:Name="chkWinRAR" Content="WinRAR"/>
                                    <CheckBox x:Name="chkPowerToys" Content="Microsoft PowerToys"/>
                                    <CheckBox x:Name="chkEverything" Content="Everything Search"/>
                                    <CheckBox x:Name="chkBitwarden" Content="Bitwarden Password Mgr"/>
                                    <CheckBox x:Name="chkSteam" Content="Steam Gaming Client"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,15,0,0">
                            <Button x:Name="btnInstallApps" Content="⚡ Install Selected Apps" Style="{StaticResource AccentGoldButton}" Width="220"/>
                            <Button x:Name="btnSelectAllApps" Content="☑ Select All" Style="{StaticResource GoldButton}" Width="130"/>
                            <Button x:Name="btnDeselectApps" Content="☐ Clear All" Style="{StaticResource GoldButton}" Width="130"/>
                            <Button x:Name="btnUpdateApps" Content="🔄 Update All Apps" Style="{StaticResource GoldButton}" Width="180"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 2: SYSTEM TWEAKS -->
            <TabItem Header="⚙️ Golden Tweaks">
                <Border Background="#120E07" CornerRadius="0,8,8,8" BorderBrush="#5E4B14" BorderThickness="1" Padding="15">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>

                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>

                                <!-- Performance -->
                                <StackPanel Grid.Column="0" Margin="5">
                                    <TextBlock Text="🚀 Performance Tweaks" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="twkHighPerf" Content="Enable High Performance Power Plan"/>
                                    <CheckBox x:Name="twkDisableTelemetry" Content="Disable Windows Telemetry"/>
                                    <CheckBox x:Name="twkDisableGameBar" Content="Disable Game Bar / Game DVR"/>
                                    <CheckBox x:Name="twkDisableHibernation" Content="Disable Hibernation (Saves Space)"/>
                                    <CheckBox x:Name="twkDisableSysMain" Content="Disable SysMain / Superfetch"/>
                                    <CheckBox x:Name="twkDisableStartupDelay" Content="Disable Windows Startup Delay"/>
                                </StackPanel>

                                <!-- Privacy -->
                                <StackPanel Grid.Column="1" Margin="5">
                                    <TextBlock Text="🔒 Privacy &amp; Ads" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="twkDisableAds" Content="Disable Windows Advertising ID"/>
                                    <CheckBox x:Name="twkDisableCortana" Content="Disable Cortana Search Integration"/>
                                    <CheckBox x:Name="twkDisableLocation" Content="Disable Location Tracking"/>
                                    <CheckBox x:Name="twkDisableFeedback" Content="Disable Feedback Prompts"/>
                                    <CheckBox x:Name="twkDisableActivityHistory" Content="Disable Activity History Logging"/>
                                </StackPanel>

                                <!-- UI Tweaks -->
                                <StackPanel Grid.Column="2" Margin="5">
                                    <TextBlock Text="🖥️ Custom UI &amp; Explorer" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="twkShowFileExt" Content="Show File Name Extensions"/>
                                    <CheckBox x:Name="twkShowHidden" Content="Show Hidden Files &amp; Folders"/>
                                    <CheckBox x:Name="twkDarkMode" Content="Enable System Dark Mode"/>
                                    <CheckBox x:Name="twkClassicRightClick" Content="Classic Right-Click Menu (Win 11)"/>
                                    <CheckBox x:Name="twkTaskbarLeft" Content="Align Taskbar to Left (Win 11)"/>
                                    <CheckBox x:Name="twkDisableWidgets" Content="Disable Widgets / News (Win 11)"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,15,0,0">
                            <Button x:Name="btnApplyTweaks" Content="⚡ Apply Selected Tweaks" Style="{StaticResource AccentGoldButton}" Width="240"/>
                            <Button x:Name="btnSelectRecommendedTweaks" Content="✨ Select Recommended" Style="{StaticResource GoldButton}" Width="200"/>
                            <Button x:Name="btnDeselectTweaks" Content="☐ Clear All" Style="{StaticResource GoldButton}" Width="130"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 3: DEBLOAT -->
            <TabItem Header="🗑️ Debloat">
                <Border Background="#120E07" CornerRadius="0,8,8,8" BorderBrush="#5E4B14" BorderThickness="1" Padding="15">
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>

                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>

                                <StackPanel Grid.Column="0" Margin="5">
                                    <TextBlock Text="📱 Pre-Installed Windows Apps" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="db3DViewer" Content="3D Viewer &amp; Print 3D"/>
                                    <CheckBox x:Name="dbBingNews" Content="Bing News &amp; Weather"/>
                                    <CheckBox x:Name="dbFeedbackHub" Content="Feedback Hub"/>
                                    <CheckBox x:Name="dbGetHelp" Content="Get Help &amp; Tips"/>
                                    <CheckBox x:Name="dbMaps" Content="Windows Maps"/>
                                    <CheckBox x:Name="dbSolitaire" Content="Solitaire Collection"/>
                                    <CheckBox x:Name="dbMixedReality" Content="Mixed Reality Portal"/>
                                    <CheckBox x:Name="dbOfficeHub" Content="Get Office (Office Hub)"/>
                                </StackPanel>

                                <StackPanel Grid.Column="1" Margin="5">
                                    <TextBlock Text="🗑️ Additional Bloatware" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="5,5,5,10"/>
                                    <CheckBox x:Name="dbSkype" Content="Skype"/>
                                    <CheckBox x:Name="dbYourPhone" Content="Phone Link / Your Phone"/>
                                    <CheckBox x:Name="dbXboxApps" Content="Xbox Bloatware Apps"/>
                                    <CheckBox x:Name="dbZune" Content="Groove Music &amp; Movies/TV"/>
                                    <CheckBox x:Name="dbOneDrive" Content="Remove OneDrive"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,15,0,0">
                            <Button x:Name="btnRemoveDebloat" Content="🗑️ Remove Selected Bloatware" Style="{StaticResource AccentGoldButton}" Width="260"/>
                            <Button x:Name="btnSafeDebloat" Content="✅ Select Safe Bloatware" Style="{StaticResource GoldButton}" Width="200"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 4: SYSTEM REPAIR & TOOLS -->
            <TabItem Header="🛠️ Repair &amp; Tools">
                <Border Background="#120E07" CornerRadius="0,8,8,8" BorderBrush="#5E4B14" BorderThickness="1" Padding="15">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <!-- System Info -->
                        <StackPanel Grid.Column="0" Margin="10">
                            <TextBlock Text="📊 System Hardware Summary" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="0,0,0,10"/>
                            <Border Background="#1A150B" BorderBrush="#5E4B14" BorderThickness="1" CornerRadius="6" Padding="12">
                                <TextBlock x:Name="txtSysInfo" Text="Gathering System Specs..." FontFamily="Consolas" FontSize="12.5" Foreground="#FFF8DC" TextWrapping="Wrap"/>
                            </Border>

                            <TextBlock Text="🛠️ Windows Maintenance Repairs" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="0,20,0,10"/>
                            <WrapPanel>
                                <Button x:Name="btnSFC" Content="🔍 SFC System Scan" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnDISM" Content="🛠️ DISM Image Repair" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnFlushDNS" Content="🌐 Flush DNS Cache" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnClearTemp" Content="🗂️ Clean Temporary Files" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnRestorePoint" Content="💾 Create Restore Point" Style="{StaticResource GoldButton}"/>
                            </WrapPanel>
                        </StackPanel>

                        <!-- Utilities -->
                        <StackPanel Grid.Column="1" Margin="10">
                            <TextBlock Text="🔑 Windows Management" FontSize="15" FontWeight="Bold" Foreground="#FFD700" Margin="0,0,0,10"/>
                            <WrapPanel>
                                <Button x:Name="btnActivate" Content="👑 Activate Windows (MAS)" Style="{StaticResource AccentGoldButton}"/>
                                <Button x:Name="btnDiskCleanup" Content="🧹 Disk Cleanup" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnDevManager" Content="🔌 Device Manager" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnServices" Content="⚙️ Windows Services" Style="{StaticResource GoldButton}"/>
                                <Button x:Name="btnTaskMgr" Content="📋 Task Manager" Style="{StaticResource GoldButton}"/>
                            </WrapPanel>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>
        </TabControl>

        <!-- STATUS BAR -->
        <Border Grid.Row="2" Background="#120E07" BorderBrush="#5E4B14" BorderThickness="0,1,0,0" Padding="15,8">
            <Grid>
                <TextBlock x:Name="txtStatus" Text="✨ MIDAS Ready. Select your optimizations." FontSize="12.5" Foreground="#FFD700" FontWeight="SemiBold" VerticalAlignment="Center"/>
                <ProgressBar x:Name="progressBar" Width="220" Height="14" HorizontalAlignment="Right" Background="#1A150B" Foreground="#FFD700" Value="0" Visibility="Hidden"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# ============================================================
# LOAD GUI & ANIMATION ENGINE
# ============================================================
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Get Named Controls
$XAML.SelectNodes("//*[@*[contains(translate(name(),'x','X'),'Name')]]") | ForEach-Object {
    Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name) -Scope Script
}

# ── Start Liquid Gold Background Rotation Animation ──
$goldRotateTransform = $window.FindName("GoldRotateTransform")
if ($goldRotateTransform) {
    $doubleAnim = New-Object System.Windows.Media.Animation.DoubleAnimation
    $doubleAnim.From = 0
    $doubleAnim.To = 360
    $doubleAnim.Duration = New-Object System.Windows.Duration([TimeSpan]::FromSeconds(15))
    $doubleAnim.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
    $goldRotateTransform.BeginAnimation([System.Windows.Media.RotateTransform]::AngleProperty, $doubleAnim)
}

# ============================================================
# REAL FUNCTIONALITY BACKEND
# ============================================================

function Set-RegDword {
    param([string]$Path, [string]$Name, [int]$Value)
    try {
        if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type DWord -Force
    } catch {}
}

function Update-Status([string]$msg) {
    $txtStatus.Dispatcher.Invoke([action]{ $txtStatus.Text = "✨ $msg" })
}

# Load Hardware Specs
$window.Add_Loaded({
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
        $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
        $gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
        $txtSysInfo.Text = "OS: $($os.Caption) ($($os.OSArchitecture))`nCPU: $($cpu.Name)`nRAM: $ram GB RAM`nGPU: $gpu"
    } catch {
        $txtSysInfo.Text = "System information loaded."
    }
})

# ── 1. APP INSTALLER LOGIC (WinGet) ──
$AppMap = @{
    chkChrome = "Google.Chrome"; chkFirefox = "Mozilla.Firefox"; chkBrave = "Brave.Brave"
    chkEdge = "Microsoft.Edge"; chkOperaGX = "Opera.OperaGX"; chkDiscord = "Discord.Discord"
    chkTelegram = "Telegram.TelegramDesktop"; chkWhatsApp = "WhatsApp.WhatsApp"; chkZoom = "Zoom.Zoom"
    chkVSCode = "Microsoft.VisualStudioCode"; chkGit = "Git.Git"; chkNodeJS = "OpenJS.NodeJS.LTS"
    chkPython = "Python.Python.3.12"; chkTerminal = "Microsoft.WindowsTerminal"
    chkPowerShell7 = "Microsoft.PowerShell"; chkDocker = "Docker.DockerDesktop"
    chkNotepadPP = "Notepad++.Notepad++"; chkVLC = "VideoLAN.VLC"; chkSpotify = "Spotify.Spotify"
    chkOBS = "OBSProject.OBSStudio"; chkGIMP = "GIMP.GIMP"; chkShareX = "ShareX.ShareX"
    chkHandbrake = "HandBrake.HandBrake"; "chk7Zip" = "7zip.7zip"; chkWinRAR = "RARLab.WinRAR"
    chkPowerToys = "Microsoft.PowerToys"; chkEverything = "voidtools.Everything"
    chkBitwarden = "Bitwarden.Bitwarden"; chkSteam = "Valve.Steam"
}

$btnInstallApps.Add_Click({
    $selected = @()
    foreach ($key in $AppMap.Keys) {
        $box = $window.FindName($key)
        if ($box -and $box.IsChecked) { $selected += $AppMap[$key] }
    }
    
    if ($selected.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Please select at least one application to install.", "MIDAS", "OK", "Information")
        return
    }

    $window.IsEnabled = $false
    foreach ($app in $selected) {
        Update-Status "Installing $app via WinGet..."
        winget install --id $app --silent --accept-package-agreements --accept-source-agreements --exact
    }
    $window.IsEnabled = $true
    Update-Status "All selected applications installed successfully!"
    [System.Windows.MessageBox]::Show("Selected applications have been installed!", "MIDAS Complete", "OK", "Information")
})

$btnSelectAllApps.Add_Click({ foreach ($key in $AppMap.Keys) { ($window.FindName($key)).IsChecked = $true } })
$btnDeselectApps.Add_Click({ foreach ($key in $AppMap.Keys) { ($window.FindName($key)).IsChecked = $false } })

# ── 2. TWEAKS LOGIC ──
$btnApplyTweaks.Add_Click({
    $window.IsEnabled = $false
    Update-Status "Applying Golden Tweaks..."

    if ($twkHighPerf.IsChecked) { powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c }
    if ($twkDisableTelemetry.IsChecked) {
        Set-RegDword "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
        Stop-Service DiagTrack -ErrorAction SilentlyContinue
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
    }
    if ($twkDisableGameBar.IsChecked) {
        Set-RegDword "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0
        Set-RegDword "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0
    }
    if ($twkDisableHibernation.IsChecked) { powercfg -h off }
    if ($twkDisableAds.IsChecked) { Set-RegDword "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0 }
    if ($twkShowFileExt.IsChecked) { Set-RegDword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0 }
    if ($twkShowHidden.IsChecked) { Set-RegDword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1 }
    if ($twkDarkMode.IsChecked) {
        Set-RegDword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
        Set-RegDword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
    }
    if ($twkClassicRightClick.IsChecked) {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value "" -Force
    }

    $window.IsEnabled = $true
    Update-Status "Selected Tweaks Applied successfully!"
    [System.Windows.MessageBox]::Show("Selected tweaks applied!", "MIDAS Tweaks", "OK", "Information")
})

$btnSelectRecommendedTweaks.Add_Click({
    $twkHighPerf.IsChecked = $true
    $twkDisableTelemetry.IsChecked = $true
    $twkDisableAds.IsChecked = $true
    $twkShowFileExt.IsChecked = $true
    $twkDarkMode.IsChecked = $true
})

# ── 3. DEBLOAT LOGIC ──
$BloatMap = @{
    db3DViewer = "*3DViewer*"; dbBingNews = "*BingNews*"; dbFeedbackHub = "*WindowsFeedbackHub*"
    dbGetHelp = "*GetHelp*"; dbMaps = "*WindowsMaps*"; dbSolitaire = "*SolitaireCollection*"
    dbMixedReality = "*MixedReality.Portal*"; dbOfficeHub = "*MicrosoftOfficeHub*"
    dbSkype = "*SkypeApp*"; dbYourPhone = "*YourPhone*"; dbXboxApps = "*Xbox*"
    dbZune = "*Zune*"
}

$btnRemoveDebloat.Add_Click({
    $window.IsEnabled = $false
    foreach ($key in $BloatMap.Keys) {
        $box = $window.FindName($key)
        if ($box -and $box.IsChecked) {
            $pkg = $BloatMap[$key]
            Update-Status "Removing $pkg..."
            Get-AppxPackage -Name $pkg -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        }
    }
    if ($dbOneDrive.IsChecked) {
        Update-Status "Uninstalling OneDrive..."
        taskkill /f /im OneDrive.exe 2>$null
        if (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") { & "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall }
    }
    $window.IsEnabled = $true
    Update-Status "Debloat Complete!"
    [System.Windows.MessageBox]::Show("Selected bloatware removed!", "MIDAS Debloat", "OK", "Information")
})

$btnSafeDebloat.Add_Click({
    $db3DViewer.IsChecked = $true; $dbBingNews.IsChecked = $true; $dbFeedbackHub.IsChecked = $true
    $dbGetHelp.IsChecked = $true; $dbSolitaire.IsChecked = $true; $dbMixedReality.IsChecked = $true
})

# ── 4. REPAIR & UTILITIES ──
$btnSFC.Add_Click({ Start-Process powershell -ArgumentList "-NoExit -Command sfc /scannow" -Verb RunAs })
$btnDISM.Add_Click({ Start-Process powershell -ArgumentList "-NoExit -Command DISM /Online /Cleanup-Image /RestoreHealth" -Verb RunAs })
$btnFlushDNS.Add_Click({ ipconfig /flushdns; Update-Status "DNS Cache Flushed!" })
$btnClearTemp.Add_Click({
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Update-Status "Temporary Files Cleaned!"
})
$btnRestorePoint.Add_Click({
    Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
    Checkpoint-Computer -Description "MIDAS Restore Point" -RestorePointType MODIFY_SETTINGS
    Update-Status "System Restore Point Created!"
})
$btnActivate.Add_Click({ Start-Process powershell -ArgumentList "-Command irm https://get.activated.win | iex" -Verb RunAs })
$btnDiskCleanup.Add_Click({ Start-Process cleanmgr })
$btnDevManager.Add_Click({ Start-Process devmgmt.msc })
$btnServices.Add_Click({ Start-Process services.msc })
$btnTaskMgr.Add_Click({ Start-Process taskmgr })

# ── SHOW WINDOW ──
Update-Status "✨ MIDAS Active. Gold Theme Engaged."
$window.ShowDialog() | Out-Null
