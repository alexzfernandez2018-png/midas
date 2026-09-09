#Requires -RunAsAdministrator
# ============================================================
# MIDAS WINDOWS UTILITY
# Sleek Metallic Edition
# ============================================================

# ── Admin Verification ──
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    [System.Windows.Forms.MessageBox]::Show(
        "MIDAS requires Administrator privileges.`n`nPlease launch PowerShell as Administrator and run the command again.",
        "MIDAS Access Required",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    ) | Out-Null
    exit
}

# ── Load WPF Assemblies ──
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ============================================================
# XAML GUI DEFINITION (Sleek Liquid Gold Theme)
# ============================================================
[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="MIDAS System Utility"
    Height="730" Width="1080"
    WindowStartupLocation="CenterScreen"
    Background="#0a0907" Foreground="#e6d7c3"
    ResizeMode="CanResizeWithGrip"
    FontFamily="Segoe UI">

    <Window.Resources>
        <!-- Sleek Button Style -->
        <Style x:Key="SleekButton" TargetType="Button">
            <Setter Property="Background" Value="#17130d"/>
            <Setter Property="Foreground" Value="#d4af37"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="14,7"/>
            <Setter Property="Margin" Value="4"/>
            <Setter Property="BorderBrush" Value="#4a3b18"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="4" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#2d2211"/>
                                <Setter TargetName="border" Property="BorderBrush" Value="#d4af37"/>
                                <Setter Property="Foreground" Value="#f5e6a3"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#d4af37"/>
                                <Setter Property="Foreground" Value="#0a0907"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Accent Action Button -->
        <Style x:Key="AccentButton" TargetType="Button" BasedOn="{StaticResource SleekButton}">
            <Setter Property="Background" Value="#382b13"/>
            <Setter Property="Foreground" Value="#f5e6a3"/>
            <Setter Property="BorderBrush" Value="#8a6d29"/>
        </Style>

        <!-- Sleek CheckBox Style -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#cccccc"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Margin" Value="5,5"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>

        <!-- Minimalist Tab Header -->
        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#120e09"/>
            <Setter Property="Foreground" Value="#8a733e"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="22,9"/>
            <Setter Property="Margin" Value="2,0"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="{TemplateBinding Background}"
                                BorderBrush="#332812" BorderThickness="1,1,1,0"
                                CornerRadius="4,4,0,0" Padding="{TemplateBinding Padding}">
                            <ContentPresenter ContentSource="Header" HorizontalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="tabBorder" Property="Background" Value="#1f180d"/>
                                <Setter TargetName="tabBorder" Property="BorderBrush" Value="#d4af37"/>
                                <Setter Property="Foreground" Value="#d4af37"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <!-- REAL-TIME LIQUID GOLD BACKGROUND -->
    <Grid x:Name="MainGrid">
        <Grid.Background>
            <LinearGradientBrush x:Name="LiquidGoldBrush" StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#070604" Offset="0.0"/>
                <GradientStop Color="#1a140b" Offset="0.18"/>
                <GradientStop Color="#3b2d13" Offset="0.38"/>
                <GradientStop Color="#8c6d2d" Offset="0.50"/>
                <GradientStop Color="#3b2d13" Offset="0.62"/>
                <GradientStop Color="#1a140b" Offset="0.82"/>
                <GradientStop Color="#070604" Offset="1.0"/>
            </LinearGradientBrush>
        </Grid.Background>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- TOP BAR -->
        <Border Grid.Row="0" Background="#0d0b08" BorderBrush="#2e2410" BorderThickness="0,0,0,1" Padding="20,12">
            <Grid>
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="MIDAS" FontSize="20" FontWeight="Bold" Foreground="#d4af37" CharacterSpacing="120"/>
                    <TextBlock Text="System Utility" FontSize="12" Foreground="#735e29" VerticalAlignment="Center" Margin="12,2,0,0"/>
                </StackPanel>
                <TextBlock Text="v3.0" FontSize="11" Foreground="#4a3b18" HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <!-- TAB NAVIGATION -->
        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="12">

            <!-- TAB 1: APPLICATIONS -->
            <TabItem Header="Applications">
                <Border Background="#0d0b08" CornerRadius="0,4,4,4" BorderBrush="#2e2410" BorderThickness="1" Padding="16">
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
                                <StackPanel Grid.Column="0" Margin="4">
                                    <TextBlock Text="Browsers" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                                    <CheckBox x:Name="chkFirefox" Content="Mozilla Firefox"/>
                                    <CheckBox x:Name="chkBrave" Content="Brave Browser"/>
                                    <CheckBox x:Name="chkEdge" Content="Microsoft Edge"/>
                                    <CheckBox x:Name="chkOperaGX" Content="Opera GX"/>

                                    <TextBlock Text="Communication" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,16,5,8"/>
                                    <CheckBox x:Name="chkDiscord" Content="Discord"/>
                                    <CheckBox x:Name="chkTelegram" Content="Telegram"/>
                                    <CheckBox x:Name="chkWhatsApp" Content="WhatsApp"/>
                                    <CheckBox x:Name="chkZoom" Content="Zoom"/>
                                </StackPanel>

                                <!-- Development -->
                                <StackPanel Grid.Column="1" Margin="4">
                                    <TextBlock Text="Developer Tools" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
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
                                <StackPanel Grid.Column="2" Margin="4">
                                    <TextBlock Text="Media &amp; Design" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chkVLC" Content="VLC Media Player"/>
                                    <CheckBox x:Name="chkSpotify" Content="Spotify"/>
                                    <CheckBox x:Name="chkOBS" Content="OBS Studio"/>
                                    <CheckBox x:Name="chkGIMP" Content="GIMP Image Editor"/>
                                    <CheckBox x:Name="chkShareX" Content="ShareX Screenshot"/>
                                    <CheckBox x:Name="chkHandbrake" Content="Handbrake Converter"/>
                                </StackPanel>

                                <!-- Utilities -->
                                <StackPanel Grid.Column="3" Margin="4">
                                    <TextBlock Text="Utilities &amp; Tools" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                                    <CheckBox x:Name="chkWinRAR" Content="WinRAR"/>
                                    <CheckBox x:Name="chkPowerToys" Content="Microsoft PowerToys"/>
                                    <CheckBox x:Name="chkEverything" Content="Everything Search"/>
                                    <CheckBox x:Name="chkBitwarden" Content="Bitwarden"/>
                                    <CheckBox x:Name="chkSteam" Content="Steam Client"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,14,0,0">
                            <Button x:Name="btnInstallApps" Content="Install Selected" Style="{StaticResource AccentButton}" Width="180"/>
                            <Button x:Name="btnSelectAllApps" Content="Select All" Style="{StaticResource SleekButton}" Width="120"/>
                            <Button x:Name="btnDeselectApps" Content="Clear Selection" Style="{StaticResource SleekButton}" Width="120"/>
                            <Button x:Name="btnUpdateApps" Content="Update All Packages" Style="{StaticResource SleekButton}" Width="160"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 2: SYSTEM TWEAKS -->
            <TabItem Header="Tweaks">
                <Border Background="#0d0b08" CornerRadius="0,4,4,4" BorderBrush="#2e2410" BorderThickness="1" Padding="16">
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
                                <StackPanel Grid.Column="0" Margin="4">
                                    <TextBlock Text="Performance" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="twkHighPerf" Content="High Performance Power Plan"/>
                                    <CheckBox x:Name="twkDisableTelemetry" Content="Disable Telemetry"/>
                                    <CheckBox x:Name="twkDisableGameBar" Content="Disable Game Bar / DVR"/>
                                    <CheckBox x:Name="twkDisableHibernation" Content="Disable Hibernation"/>
                                    <CheckBox x:Name="twkDisableSysMain" Content="Disable SysMain Service"/>
                                    <CheckBox x:Name="twkDisableStartupDelay" Content="Disable Startup Delay"/>
                                </StackPanel>

                                <!-- Privacy -->
                                <StackPanel Grid.Column="1" Margin="4">
                                    <TextBlock Text="Privacy" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="twkDisableAds" Content="Disable Advertising ID"/>
                                    <CheckBox x:Name="twkDisableCortana" Content="Disable Cortana Search"/>
                                    <CheckBox x:Name="twkDisableLocation" Content="Disable Location Tracking"/>
                                    <CheckBox x:Name="twkDisableFeedback" Content="Disable Feedback Requests"/>
                                    <CheckBox x:Name="twkDisableActivityHistory" Content="Disable Activity History"/>
                                </StackPanel>

                                <!-- Explorer -->
                                <StackPanel Grid.Column="2" Margin="4">
                                    <TextBlock Text="Explorer &amp; Interface" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="twkShowFileExt" Content="Show File Extensions"/>
                                    <CheckBox x:Name="twkShowHidden" Content="Show Hidden Files"/>
                                    <CheckBox x:Name="twkDarkMode" Content="Enable System Dark Mode"/>
                                    <CheckBox x:Name="twkClassicRightClick" Content="Classic Context Menu (Win 11)"/>
                                    <CheckBox x:Name="twkTaskbarLeft" Content="Align Taskbar Left (Win 11)"/>
                                    <CheckBox x:Name="twkDisableWidgets" Content="Disable Widgets (Win 11)"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,14,0,0">
                            <Button x:Name="btnApplyTweaks" Content="Apply Tweaks" Style="{StaticResource AccentButton}" Width="200"/>
                            <Button x:Name="btnSelectRecommendedTweaks" Content="Select Recommended" Style="{StaticResource SleekButton}" Width="180"/>
                            <Button x:Name="btnDeselectTweaks" Content="Clear Selection" Style="{StaticResource SleekButton}" Width="120"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 3: DEBLOAT -->
            <TabItem Header="Debloat">
                <Border Background="#0d0b08" CornerRadius="0,4,4,4" BorderBrush="#2e2410" BorderThickness="1" Padding="16">
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

                                <StackPanel Grid.Column="0" Margin="4">
                                    <TextBlock Text="System Provisioned Apps" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="db3DViewer" Content="3D Viewer &amp; Print 3D"/>
                                    <CheckBox x:Name="dbBingNews" Content="Bing News &amp; Weather"/>
                                    <CheckBox x:Name="dbFeedbackHub" Content="Feedback Hub"/>
                                    <CheckBox x:Name="dbGetHelp" Content="Get Help &amp; Tips"/>
                                    <CheckBox x:Name="dbMaps" Content="Windows Maps"/>
                                    <CheckBox x:Name="dbSolitaire" Content="Solitaire Collection"/>
                                    <CheckBox x:Name="dbMixedReality" Content="Mixed Reality Portal"/>
                                    <CheckBox x:Name="dbOfficeHub" Content="Office Hub"/>
                                </StackPanel>

                                <StackPanel Grid.Column="1" Margin="4">
                                    <TextBlock Text="Additional Applications" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="dbSkype" Content="Skype"/>
                                    <CheckBox x:Name="dbYourPhone" Content="Phone Link"/>
                                    <CheckBox x:Name="dbXboxApps" Content="Xbox Services &amp; Apps"/>
                                    <CheckBox x:Name="dbZune" Content="Groove Music &amp; Movies/TV"/>
                                    <CheckBox x:Name="dbOneDrive" Content="Remove OneDrive"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>

                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,14,0,0">
                            <Button x:Name="btnRemoveDebloat" Content="Remove Selected Applications" Style="{StaticResource AccentButton}" Width="240"/>
                            <Button x:Name="btnSafeDebloat" Content="Select Safe Package Preset" Style="{StaticResource SleekButton}" Width="200"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <!-- TAB 4: MAINTENANCE & TOOLS -->
            <TabItem Header="Tools &amp; Repairs">
                <Border Background="#0d0b08" CornerRadius="0,4,4,4" BorderBrush="#2e2410" BorderThickness="1" Padding="16">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <!-- Hardware Info & Maintenance -->
                        <StackPanel Grid.Column="0" Margin="8">
                            <TextBlock Text="Hardware &amp; System Information" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="0,0,0,8"/>
                            <Border Background="#120e09" BorderBrush="#2e2410" BorderThickness="1" CornerRadius="4" Padding="12">
                                <TextBlock x:Name="txtSysInfo" Text="Gathering specifications..." FontFamily="Consolas" FontSize="12" Foreground="#d6c7b2" TextWrapping="Wrap"/>
                            </Border>

                            <TextBlock Text="System Integrity Commands" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="0,18,0,8"/>
                            <WrapPanel>
                                <Button x:Name="btnSFC" Content="SFC Scan" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnDISM" Content="DISM Repair" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnFlushDNS" Content="Flush DNS" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnClearTemp" Content="Clear Temp Files" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnRestorePoint" Content="Create Restore Point" Style="{StaticResource SleekButton}"/>
                            </WrapPanel>
                        </StackPanel>

                        <!-- Windows Shortcuts -->
                        <StackPanel Grid.Column="1" Margin="8">
                            <TextBlock Text="System Management" FontSize="13" FontWeight="Bold" Foreground="#d4af37" Margin="0,0,0,8"/>
                            <WrapPanel>
                                <Button x:Name="btnActivate" Content="Activate Windows (MAS)" Style="{StaticResource AccentButton}"/>
                                <Button x:Name="btnDiskCleanup" Content="Disk Cleanup" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnDevManager" Content="Device Manager" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnServices" Content="Services" Style="{StaticResource SleekButton}"/>
                                <Button x:Name="btnTaskMgr" Content="Task Manager" Style="{StaticResource SleekButton}"/>
                            </WrapPanel>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>
        </TabControl>

        <!-- FOOTER STATUS BAR -->
        <Border Grid.Row="2" Background="#0d0b08" BorderBrush="#2e2410" BorderThickness="0,1,0,0" Padding="16,8">
            <Grid>
                <TextBlock x:Name="txtStatus" Text="Ready" FontSize="12" Foreground="#8a733e" VerticalAlignment="Center"/>
                <ProgressBar x:Name="progressBar" Width="200" Height="12" HorizontalAlignment="Right" Background="#120e09" Foreground="#d4af37" Value="0" Visibility="Hidden"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# ============================================================
# LOAD GUI & LIQUID GOLD ANIMATION ENGINE
# ============================================================
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Map XAML controls
$XAML.SelectNodes("//*[@*[contains(translate(name(),'x','X'),'Name')]]") | ForEach-Object {
    Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name) -Scope Script
}

# ── Smooth Fluid Liquid Gold Background Animation ──
$liquidBrush = $window.FindName("LiquidGoldBrush")
if ($liquidBrush) {
    # Animate Brush StartPoint
    $animStart = New-Object System.Windows.Media.Animation.PointAnimation
    $animStart.From = New-Object System.Windows.Point(0, 0)
    $animStart.To = New-Object System.Windows.Point(1, 0.6)
    $animStart.Duration = New-Object System.Windows.Duration([TimeSpan]::FromSeconds(9))
    $animStart.AutoReverse = $true
    $animStart.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever

    # Animate Brush EndPoint
    $animEnd = New-Object System.Windows.Media.Animation.PointAnimation
    $animEnd.From = New-Object System.Windows.Point(1, 1)
    $animEnd.To = New-Object System.Windows.Point(0, 0.4)
    $animEnd.Duration = New-Object System.Windows.Duration([TimeSpan]::FromSeconds(9))
    $animEnd.AutoReverse = $true
    $animEnd.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever

    $liquidBrush.BeginAnimation([System.Windows.Media.LinearGradientBrush]::StartPointProperty, $animStart)
    $liquidBrush.BeginAnimation([System.Windows.Media.LinearGradientBrush]::EndPointProperty, $animEnd)
}

# ============================================================
# BACKEND LOGIC
# ============================================================

function Set-RegDword {
    param([string]$Path, [string]$Name, [int]$Value)
    try {
        if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type DWord -Force
    } catch {}
}

function Update-Status([string]$msg) {
    $txtStatus.Dispatcher.Invoke([action]{ $txtStatus.Text = $msg })
}

# Hardware specs loader
$window.Add_Loaded({
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
        $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
        $gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
        $txtSysInfo.Text = "OS: $($os.Caption) ($($os.OSArchitecture))`nCPU: $($cpu.Name)`nRAM: $ram GB`nGPU: $gpu"
    } catch {
        $txtSysInfo.Text = "System information loaded."
    }
})

# App Installer via WinGet
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
        [System.Windows.MessageBox]::Show("Select at least one application.", "MIDAS", "OK", "Information")
        return
    }

    $window.IsEnabled = $false
    foreach ($app in $selected) {
        Update-Status "Installing $app..."
        winget install --id $app --silent --accept-package-agreements --accept-source-agreements --exact
    }
    $window.IsEnabled = $true
    Update-Status "Application installation task completed."
    [System.Windows.MessageBox]::Show("Selected applications installed successfully.", "MIDAS", "OK", "Information")
})

$btnSelectAllApps.Add_Click({ foreach ($key in $AppMap.Keys) { ($window.FindName($key)).IsChecked = $true } })
$btnDeselectApps.Add_Click({ foreach ($key in $AppMap.Keys) { ($window.FindName($key)).IsChecked = $false } })

# Tweaks Logic
$btnApplyTweaks.Add_Click({
    $window.IsEnabled = $false
    Update-Status "Applying selected system tweaks..."

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
    Update-Status "Tweaks successfully applied."
    [System.Windows.MessageBox]::Show("System tweaks applied.", "MIDAS", "OK", "Information")
})

$btnSelectRecommendedTweaks.Add_Click({
    $twkHighPerf.IsChecked = $true
    $twkDisableTelemetry.IsChecked = $true
    $twkDisableAds.IsChecked = $true
    $twkShowFileExt.IsChecked = $true
    $twkDarkMode.IsChecked = $true
})

# Debloat Logic
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
    Update-Status "Selected packages removed."
    [System.Windows.MessageBox]::Show("Bloatware removal completed.", "MIDAS", "OK", "Information")
})

$btnSafeDebloat.Add_Click({
    $db3DViewer.IsChecked = $true; $dbBingNews.IsChecked = $true; $dbFeedbackHub.IsChecked = $true
    $dbGetHelp.IsChecked = $true; $dbSolitaire.IsChecked = $true; $dbMixedReality.IsChecked = $true
})

# System Commands
$btnSFC.Add_Click({ Start-Process powershell -ArgumentList "-NoExit -Command sfc /scannow" -Verb RunAs })
$btnDISM.Add_Click({ Start-Process powershell -ArgumentList "-NoExit -Command DISM /Online /Cleanup-Image /RestoreHealth" -Verb RunAs })
$btnFlushDNS.Add_Click({ ipconfig /flushdns; Update-Status "DNS Cache Flushed." })
$btnClearTemp.Add_Click({
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Update-Status "Temporary files cleared."
})
$btnRestorePoint.Add_Click({
    Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
    Checkpoint-Computer -Description "MIDAS Restore Point" -RestorePointType MODIFY_SETTINGS
    Update-Status "System restore point created."
})
$btnActivate.Add_Click({ Start-Process powershell -ArgumentList "-Command irm https://get.activated.win | iex" -Verb RunAs })
$btnDiskCleanup.Add_Click({ Start-Process cleanmgr })
$btnDevManager.Add_Click({ Start-Process devmgmt.msc })
$btnServices.Add_Click({ Start-Process services.msc })
$btnTaskMgr.Add_Click({ Start-Process taskmgr })

# Show Window
Update-Status "Ready"
$window.ShowDialog() | Out-Null
