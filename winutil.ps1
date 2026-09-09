#Requires -RunAsAdministrator
# ============================================================
# ULTIMATE WINDOWS UTILITY - Chris Titus Tech Style
# ============================================================

# ── Ensure running as Admin ──
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ============================================================
# XAML GUI DEFINITION
# ============================================================
[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="⚡ Ultimate Windows Utility v2.0"
    Height="720" Width="1050"
    WindowStartupLocation="CenterScreen"
    Background="#1a1a2e" Foreground="White"
    ResizeMode="CanResizeWithGrip">

    <Window.Resources>
        <!-- Button Style -->
        <Style x:Key="ModernButton" TargetType="Button">
            <Setter Property="Background" Value="#16213e"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="15,10"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}"
                                CornerRadius="8" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#0f3460"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#e94560"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- Action Button (Accent) -->
        <Style x:Key="AccentButton" TargetType="Button" BasedOn="{StaticResource ModernButton}">
            <Setter Property="Background" Value="#e94560"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}"
                                CornerRadius="8" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#ff6b6b"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <!-- CheckBox Style -->
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#e0e0e0"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="Margin" Value="5,4"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>

        <!-- Tab Style -->
        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#16213e"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="20,10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="#16213e" CornerRadius="8,8,0,0"
                                Padding="{TemplateBinding Padding}" Margin="2,0">
                            <ContentPresenter ContentSource="Header" HorizontalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="tabBorder" Property="Background" Value="#e94560"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="tabBorder" Property="Background" Value="#0f3460"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#0f3460" Padding="20,12">
            <Grid>
                <TextBlock Text="⚡ Ultimate Windows Utility" FontSize="22" FontWeight="Bold"
                           Foreground="White" HorizontalAlignment="Left" VerticalAlignment="Center"/>
                <TextBlock Text="v2.0 | Run as Admin" FontSize="12" Foreground="#aaa"
                           HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <!-- Tab Control -->
        <TabControl Grid.Row="1" Background="#1a1a2e" BorderThickness="0" Margin="10">

            <!-- TAB 1: INSTALL APPS -->
            <TabItem Header="📦 Install Apps">
                <Grid Margin="10">
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
                                <TextBlock Text="🌐 Browsers" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="chkFirefox" Content="Firefox"/>
                                <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                                <CheckBox x:Name="chkBrave" Content="Brave Browser"/>
                                <CheckBox x:Name="chkEdge" Content="Microsoft Edge"/>
                                <CheckBox x:Name="chkVivaldi" Content="Vivaldi"/>
                                <CheckBox x:Name="chkOperaGX" Content="Opera GX"/>
                                <CheckBox x:Name="chkTor" Content="Tor Browser"/>
                                <CheckBox x:Name="chkLibreWolf" Content="LibreWolf"/>

                                <TextBlock Text="💬 Communication" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,15,5,8"/>
                                <CheckBox x:Name="chkDiscord" Content="Discord"/>
                                <CheckBox x:Name="chkTelegram" Content="Telegram"/>
                                <CheckBox x:Name="chkSlack" Content="Slack"/>
                                <CheckBox x:Name="chkZoom" Content="Zoom"/>
                                <CheckBox x:Name="chkTeams" Content="Microsoft Teams"/>
                                <CheckBox x:Name="chkSignal" Content="Signal"/>
                                <CheckBox x:Name="chkThunderbird" Content="Thunderbird"/>
                            </StackPanel>

                            <!-- Development -->
                            <StackPanel Grid.Column="1" Margin="5">
                                <TextBlock Text="💻 Development" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="chkVSCode" Content="VS Code"/>
                                <CheckBox x:Name="chkGit" Content="Git"/>
                                <CheckBox x:Name="chkNodeJS" Content="Node.js LTS"/>
                                <CheckBox x:Name="chkPython" Content="Python 3"/>
                                <CheckBox x:Name="chkJava" Content="Java JDK (Adoptium)"/>
                                <CheckBox x:Name="chkDocker" Content="Docker Desktop"/>
                                <CheckBox x:Name="chkPostman" Content="Postman"/>
                                <CheckBox x:Name="chkSublime" Content="Sublime Text"/>
                                <CheckBox x:Name="chkNotepadPP" Content="Notepad++"/>
                                <CheckBox x:Name="chkWindowsTerminal" Content="Windows Terminal"/>
                                <CheckBox x:Name="chkPowerShell7" Content="PowerShell 7"/>
                                <CheckBox x:Name="chkWinSCP" Content="WinSCP"/>
                                <CheckBox x:Name="chkPuTTY" Content="PuTTY"/>
                                <CheckBox x:Name="chkGitHub" Content="GitHub Desktop"/>
                                <CheckBox x:Name="chkRust" Content="Rust"/>
                                <CheckBox x:Name="chkGo" Content="Go"/>
                            </StackPanel>

                            <!-- Media & Utilities -->
                            <StackPanel Grid.Column="2" Margin="5">
                                <TextBlock Text="🎬 Media" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="chkVLC" Content="VLC Media Player"/>
                                <CheckBox x:Name="chkSpotify" Content="Spotify"/>
                                <CheckBox x:Name="chkOBS" Content="OBS Studio"/>
                                <CheckBox x:Name="chkAudacity" Content="Audacity"/>
                                <CheckBox x:Name="chkGIMP" Content="GIMP"/>
                                <CheckBox x:Name="chkHandBrake" Content="HandBrake"/>
                                <CheckBox x:Name="chkKDEnlive" Content="Kdenlive"/>
                                <CheckBox x:Name="chkShareX" Content="ShareX"/>
                                <CheckBox x:Name="chkIrfanView" Content="IrfanView"/>

                                <TextBlock Text="📄 Documents" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,15,5,8"/>
                                <CheckBox x:Name="chkLibreOffice" Content="LibreOffice"/>
                                <CheckBox x:Name="chkAdobeReader" Content="Adobe Acrobat Reader"/>
                                <CheckBox x:Name="chkSumatraPDF" Content="Sumatra PDF"/>
                                <CheckBox x:Name="chkObsidian" Content="Obsidian"/>
                                <CheckBox x:Name="chkNotion" Content="Notion"/>
                            </StackPanel>

                            <!-- Utilities & Gaming -->
                            <StackPanel Grid.Column="3" Margin="5">
                                <TextBlock Text="🔧 Utilities" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                                <CheckBox x:Name="chkWinRAR" Content="WinRAR"/>
                                <CheckBox x:Name="chkEverything" Content="Everything Search"/>
                                <CheckBox x:Name="chkPowerToys" Content="PowerToys"/>
                                <CheckBox x:Name="chkTreeSize" Content="TreeSize Free"/>
                                <CheckBox x:Name="chkBitwarden" Content="Bitwarden"/>
                                <CheckBox x:Name="chkKeePass" Content="KeePass"/>
                                <CheckBox x:Name="chkqBittorrent" Content="qBittorrent"/>
                                <CheckBox x:Name="chkWireshark" Content="Wireshark"/>
                                <CheckBox x:Name="chkCPUZ" Content="CPU-Z"/>
                                <CheckBox x:Name="chkHWiNFO" Content="HWiNFO"/>

                                <TextBlock Text="🎮 Gaming" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,15,5,8"/>
                                <CheckBox x:Name="chkSteam" Content="Steam"/>
                                <CheckBox x:Name="chkEpic" Content="Epic Games Launcher"/>
                                <CheckBox x:Name="chkEAApp" Content="EA App"/>
                                <CheckBox x:Name="chkGOG" Content="GOG Galaxy"/>
                            </StackPanel>
                        </Grid>
                    </ScrollViewer>

                    <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10">
                        <Button x:Name="btnInstallSelected" Content="📦 Install Selected"
                                Style="{StaticResource AccentButton}" Width="200"/>
                        <Button x:Name="btnSelectAll" Content="☑ Select All"
                                Style="{StaticResource ModernButton}" Width="150"/>
                        <Button x:Name="btnDeselectAll" Content="☐ Deselect All"
                                Style="{StaticResource ModernButton}" Width="150"/>
                        <Button x:Name="btnUpdateAll" Content="🔄 Update All Installed"
                                Style="{StaticResource ModernButton}" Width="200"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- TAB 2: TWEAKS -->
            <TabItem Header="⚙️ Tweaks">
                <Grid Margin="10">
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
                                <TextBlock Text="🚀 Performance Tweaks" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="twkDisableTelemetry" Content="Disable Telemetry"/>
                                <CheckBox x:Name="twkDisableCortana" Content="Disable Cortana"/>
                                <CheckBox x:Name="twkDisableGameBar" Content="Disable Game Bar/DVR"/>
                                <CheckBox x:Name="twkDisableHibernation" Content="Disable Hibernation"/>
                                <CheckBox x:Name="twkPowerHighPerf" Content="Set Power Plan: High Performance"/>
                                <CheckBox x:Name="twkUltimatePerf" Content="Enable Ultimate Performance Plan"/>
                                <CheckBox x:Name="twkDisableSysRestore" Content="Disable System Restore"/>
                                <CheckBox x:Name="twkDisableIndexing" Content="Disable Search Indexing"/>
                                <CheckBox x:Name="twkDisablePrefetch" Content="Disable Prefetch/Superfetch"/>
                                <CheckBox x:Name="twkVisualPerf" Content="Visual Effects: Best Performance"/>
                            </StackPanel>

                            <!-- Privacy -->
                            <StackPanel Grid.Column="1" Margin="5">
                                <TextBlock Text="🔒 Privacy Tweaks" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="twkDisableLocation" Content="Disable Location Tracking"/>
                                <CheckBox x:Name="twkDisableAds" Content="Disable Advertising ID"/>
                                <CheckBox x:Name="twkDisableWiFiSense" Content="Disable Wi-Fi Sense"/>
                                <CheckBox x:Name="twkDisableFeedback" Content="Disable Feedback Requests"/>
                                <CheckBox x:Name="twkDisableMapUpdates" Content="Disable Map Auto-Downloads"/>
                                <CheckBox x:Name="twkDisableErrorReporting" Content="Disable Error Reporting"/>
                                <CheckBox x:Name="twkDisableActivityHistory" Content="Disable Activity History"/>
                                <CheckBox x:Name="twkDisableClipboardHistory" Content="Disable Cloud Clipboard"/>
                                <CheckBox x:Name="twkDisableDiagnostic" Content="Disable Diagnostic Data"/>
                                <CheckBox x:Name="twkDisableTips" Content="Disable Tips &amp; Suggestions"/>
                            </StackPanel>

                            <!-- UI & Explorer -->
                            <StackPanel Grid.Column="2" Margin="5">
                                <TextBlock Text="🖥️ UI / Explorer Tweaks" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="twkShowFileExt" Content="Show File Extensions"/>
                                <CheckBox x:Name="twkShowHidden" Content="Show Hidden Files"/>
                                <CheckBox x:Name="twkTaskbarLeft" Content="Align Taskbar Left (Win 11)"/>
                                <CheckBox x:Name="twkDisableWidgets" Content="Disable Widgets (Win 11)"/>
                                <CheckBox x:Name="twkDisableChat" Content="Disable Chat Icon (Win 11)"/>
                                <CheckBox x:Name="twkClassicContext" Content="Classic Right-Click Menu (Win 11)"/>
                                <CheckBox x:Name="twkDisableStartupDelay" Content="Disable Startup Delay"/>
                                <CheckBox x:Name="twkDisableNewsFeeds" Content="Disable News &amp; Interests"/>
                                <CheckBox x:Name="twkDarkMode" Content="Enable Dark Mode"/>
                                <CheckBox x:Name="twkDisableMouseAccel" Content="Disable Mouse Acceleration"/>
                                <CheckBox x:Name="twkNumLockOn" Content="NumLock On at Startup"/>
                            </StackPanel>
                        </Grid>
                    </ScrollViewer>

                    <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10">
                        <Button x:Name="btnApplyTweaks" Content="⚡ Apply Selected Tweaks"
                                Style="{StaticResource AccentButton}" Width="250"/>
                        <Button x:Name="btnRecommended" Content="✅ Select Recommended"
                                Style="{StaticResource ModernButton}" Width="200"/>
                        <Button x:Name="btnDeselectTweaks" Content="☐ Deselect All"
                                Style="{StaticResource ModernButton}" Width="150"/>
                        <Button x:Name="btnRestoreDefaults" Content="↩️ Restore Defaults"
                                Style="{StaticResource ModernButton}" Width="180"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- TAB 3: DEBLOAT -->
            <TabItem Header="🗑️ Debloat">
                <Grid Margin="10">
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
                                <TextBlock Text="📱 Built-in Apps to Remove" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="dbBingNews" Content="Microsoft Bing News"/>
                                <CheckBox x:Name="dbBingWeather" Content="Microsoft Bing Weather"/>
                                <CheckBox x:Name="dbGetHelp" Content="Get Help"/>
                                <CheckBox x:Name="dbGetStarted" Content="Get Started / Tips"/>
                                <CheckBox x:Name="dbMaps" Content="Windows Maps"/>
                                <CheckBox x:Name="dbFeedbackHub" Content="Feedback Hub"/>
                                <CheckBox x:Name="dbPeople" Content="People"/>
                                <CheckBox x:Name="dbSolitaire" Content="Solitaire Collection"/>
                                <CheckBox x:Name="dbMixedReality" Content="Mixed Reality Portal"/>
                                <CheckBox x:Name="dbOneNote" Content="OneNote (UWP)"/>
                                <CheckBox x:Name="dbSkype" Content="Skype"/>
                                <CheckBox x:Name="dbYourPhone" Content="Your Phone / Phone Link"/>
                                <CheckBox x:Name="dbMail" Content="Mail and Calendar"/>
                                <CheckBox x:Name="dbGrooveMusic" Content="Groove Music"/>
                            </StackPanel>

                            <StackPanel Grid.Column="1" Margin="5">
                                <TextBlock Text="📱 More Bloatware" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,5,5,8"/>
                                <CheckBox x:Name="dbTodoList" Content="Microsoft To Do"/>
                                <CheckBox x:Name="dbPowerAutomate" Content="Power Automate"/>
                                <CheckBox x:Name="dbClipchamp" Content="Clipchamp"/>
                                <CheckBox x:Name="dbNews" Content="Microsoft News"/>
                                <CheckBox x:Name="dbOfficeHub" Content="Office Hub (Get Office)"/>
                                <CheckBox x:Name="dbZuneVideo" Content="Movies &amp; TV"/>
                                <CheckBox x:Name="dbCortana" Content="Cortana"/>
                                <CheckBox x:Name="dbOneDrive" Content="OneDrive"/>
                                <CheckBox x:Name="dbTeamsConsumer" Content="Teams (Consumer)"/>
                                <CheckBox x:Name="dbXboxApps" Content="Xbox Related Apps"/>
                                <CheckBox x:Name="dbCamera" Content="Camera"/>
                                <CheckBox x:Name="dbAlarms" Content="Alarms &amp; Clock"/>

                                <TextBlock Text="⚠️ Service Tweaks" FontSize="15" FontWeight="Bold"
                                           Foreground="#e94560" Margin="5,15,5,8"/>
                                <CheckBox x:Name="dbDisableOneDrive" Content="Disable OneDrive Integration"/>
                                <CheckBox x:Name="dbRemoveEdge" Content="Remove Edge (Risky!)"/>
                            </StackPanel>
                        </Grid>
                    </ScrollViewer>

                    <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10">
                        <Button x:Name="btnDebloat" Content="🗑️ Remove Selected Bloatware"
                                Style="{StaticResource AccentButton}" Width="280"/>
                        <Button x:Name="btnSafeDebloat" Content="✅ Select Safe to Remove"
                                Style="{StaticResource ModernButton}" Width="220"/>
                        <Button x:Name="btnDeselectDebloat" Content="☐ Deselect All"
                                Style="{StaticResource ModernButton}" Width="150"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- TAB 4: SYSTEM INFO & TOOLS -->
            <TabItem Header="🖥️ System Tools">
                <Grid Margin="10">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- System Info -->
                    <StackPanel Grid.Column="0" Margin="5">
                        <TextBlock Text="📊 System Information" FontSize="15" FontWeight="Bold"
                                   Foreground="#e94560" Margin="5,5,5,10"/>
                        <Border Background="#16213e" CornerRadius="10" Padding="15" Margin="5">
                            <TextBlock x:Name="txtSystemInfo" Text="Loading..." FontSize="12"
                                       Foreground="#e0e0e0" TextWrapping="Wrap" FontFamily="Consolas"/>
                        </Border>

                        <TextBlock Text="🔧 Quick Actions" FontSize="15" FontWeight="Bold"
                                   Foreground="#e94560" Margin="5,20,5,10"/>
                        <WrapPanel Margin="5">
                            <Button x:Name="btnDiskCleanup" Content="🧹 Disk Cleanup"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnDefrag" Content="💿 Defragment"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnSFC" Content="🔍 SFC Scan"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnDISM" Content="🛠️ DISM Repair"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnFlushDNS" Content="🌐 Flush DNS"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnClearTemp" Content="🗂️ Clear Temp Files"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnResetNetwork" Content="📡 Reset Network"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnDeviceManager" Content="🔌 Device Manager"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnTaskMgr" Content="📋 Task Manager"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnServices" Content="⚙️ Services"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnEventViewer" Content="📝 Event Viewer"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnRegedit" Content="🗃️ Registry Editor"
                                    Style="{StaticResource ModernButton}"/>
                        </WrapPanel>
                    </StackPanel>

                    <!-- Windows Features -->
                    <StackPanel Grid.Column="1" Margin="5">
                        <TextBlock Text="🪟 Windows Features" FontSize="15" FontWeight="Bold"
                                   Foreground="#e94560" Margin="5,5,5,10"/>
                        <WrapPanel Margin="5">
                            <Button x:Name="btnActivateWin" Content="🔑 Activate Windows"
                                    Style="{StaticResource AccentButton}"/>
                            <Button x:Name="btnWindowsUpdate" Content="🔄 Windows Update"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnCreateRestore" Content="💾 Create Restore Point"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnWSL" Content="🐧 Install WSL"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnHyperV" Content="📦 Enable Hyper-V"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnSandbox" Content="🏖️ Enable Sandbox"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnDotNet" Content="📘 Install .NET Runtimes"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnVCRedist" Content="📕 Install VC++ Redist"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnDirectX" Content="🎮 Install DirectX"
                                    Style="{StaticResource ModernButton}"/>
                        </WrapPanel>

                        <TextBlock Text="🔋 Power Options" FontSize="15" FontWeight="Bold"
                                   Foreground="#e94560" Margin="5,20,5,10"/>
                        <WrapPanel Margin="5">
                            <Button x:Name="btnBatteryReport" Content="🔋 Battery Report"
                                    Style="{StaticResource ModernButton}"/>
                            <Button x:Name="btnPowerCfg" Content="⚡ Power Options"
                                    Style="{StaticResource ModernButton}"/>
                        </WrapPanel>

                        <TextBlock Text="🔄 Maintenance" FontSize="15" FontWeight="Bold"
                                   Foreground="#e94560" Margin="5,20,5,10"/>
                        <WrapPanel Margin="5">
                            <Button x:Name="btnCheckHealth" Content="🏥 Full Health Check"
                                    Style="{StaticResource AccentButton}"/>
                            <Button x:Name="btnExportConfig" Content="💾 Export Config"
                                    Style="{StaticResource ModernButton}"/>
                        </WrapPanel>
                    </StackPanel>
                </Grid>
            </TabItem>
        </TabControl>

        <!-- Status Bar -->
        <Border Grid.Row="2" Background="#0f3460" Padding="15,8">
            <Grid>
                <TextBlock x:Name="txtStatus" Text="✅ Ready - Select options and click apply"
                           FontSize="12" Foreground="#e0e0e0" HorizontalAlignment="Left"
                           VerticalAlignment="Center"/>
                <ProgressBar x:Name="progressBar" Width="200" Height="18" HorizontalAlignment="Right"
                             Background="#16213e" Foreground="#e94560" Value="0" Visibility="Hidden"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# ============================================================
# LOAD WINDOW
# ============================================================
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

# ── Get all named controls ──
$XAML.SelectNodes("//*[@*[contains(translate(name(),'x','X'),'Name')]]") | ForEach-Object {
    Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name) -Scope Script
}

# ============================================================
# HELPER FUNCTIONS
# ============================================================
function Update-Status {
    param([string]$Message)
    $txtStatus.Dispatcher.Invoke([action]{
        $txtStatus.Text = $Message
    })
}

function Show-Progress {
    param([int]$Value)
    $progressBar.Dispatcher.Invoke([action]{
        $progressBar.Value = $Value
        $progressBar.Visibility = "Visible"
    })
}

function Hide-Progress {
    $progressBar.Dispatcher.Invoke([action]{
        $progressBar.Visibility = "Hidden"
        $progressBar.Value = 0
    })
}

function Ensure-WinGet {
    $wg = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $wg) {
        Update-Status "⏳ Installing WinGet..."
        try {
            Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -ErrorAction Stop
            Start-Sleep -Seconds 3
        } catch {
            [System.Windows.MessageBox]::Show(
                "WinGet not found. Please install 'App Installer' from the Microsoft Store.",
                "WinGet Required", "OK", "Warning")
            return $false
        }
    }
    return $true
}

function Install-WithWinGet {
    param([string]$PackageId, [string]$Name)
    Update-Status "📦 Installing $Name..."
    try {
        $result = winget install --id $PackageId --accept-package-agreements --accept-source-agreements -e -h 2>&1
        if ($LASTEXITCODE -eq 0 -or $result -match "already installed") {
            return $true
        }
    } catch {}
    return $false
}

function Set-RegistryValue {
    param(
        [string]$Path,
        [string]$Name,
        $Value,
        [string]$Type = "DWord"
    )
    try {
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
        return $true
    } catch {
        return $false
    }
}

# ============================================================
# WINGET PACKAGE MAP
# ============================================================
$PackageMap = @{
    # Browsers
    chkFirefox       = @{ Id = "Mozilla.Firefox";             Name = "Firefox" }
    chkChrome        = @{ Id = "Google.Chrome";               Name = "Google Chrome" }
    chkBrave         = @{ Id = "Brave.Brave";                 Name = "Brave Browser" }
    chkEdge          = @{ Id = "Microsoft.Edge";              Name = "Microsoft Edge" }
    chkVivaldi       = @{ Id = "VivaldiTechnologies.Vivaldi"; Name = "Vivaldi" }
    chkOperaGX       = @{ Id = "Opera.OperaGX";              Name = "Opera GX" }
    chkTor           = @{ Id = "TorProject.TorBrowser";       Name = "Tor Browser" }
    chkLibreWolf     = @{ Id = "LibreWolf.LibreWolf";         Name = "LibreWolf" }

    # Communication
    chkDiscord       = @{ Id = "Discord.Discord";             Name = "Discord" }
    chkTelegram      = @{ Id = "Telegram.TelegramDesktop";    Name = "Telegram" }
    chkSlack         = @{ Id = "SlackTechnologies.Slack";     Name = "Slack" }
    chkZoom          = @{ Id = "Zoom.Zoom";                   Name = "Zoom" }
    chkTeams         = @{ Id = "Microsoft.Teams";             Name = "Microsoft Teams" }
    chkSignal        = @{ Id = "OpenWhisperSystems.Signal";   Name = "Signal" }
    chkThunderbird   = @{ Id = "Mozilla.Thunderbird";         Name = "Thunderbird" }

    # Development
    chkVSCode        = @{ Id = "Microsoft.VisualStudioCode";  Name = "VS Code" }
    chkGit           = @{ Id = "Git.Git";                     Name = "Git" }
    chkNodeJS        = @{ Id = "OpenJS.NodeJS.LTS";           Name = "Node.js LTS" }
    chkPython        = @{ Id = "Python.Python.3.12";          Name = "Python 3" }
    chkJava          = @{ Id = "EclipseAdoptium.Temurin.21.JDK"; Name = "Java JDK" }
    chkDocker        = @{ Id = "Docker.DockerDesktop";        Name = "Docker Desktop" }
    chkPostman       = @{ Id = "Postman.Postman";             Name = "Postman" }
    chkSublime       = @{ Id = "SublimeHQ.SublimeText.4";    Name = "Sublime Text" }
    chkNotepadPP     = @{ Id = "Notepad++.Notepad++";        Name = "Notepad++" }
    chkWindowsTerminal = @{ Id = "Microsoft.WindowsTerminal"; Name = "Windows Terminal" }
    chkPowerShell7   = @{ Id = "Microsoft.PowerShell";       Name = "PowerShell 7" }
    chkWinSCP        = @{ Id = "WinSCP.WinSCP";              Name = "WinSCP" }
    chkPuTTY         = @{ Id = "PuTTY.PuTTY";                Name = "PuTTY" }
    chkGitHub        = @{ Id = "GitHub.GitHubDesktop";        Name = "GitHub Desktop" }
    chkRust          = @{ Id = "Rustlang.Rust.MSVC";         Name = "Rust" }
    chkGo            = @{ Id = "GoLang.Go";                   Name = "Go" }

    # Media
    chkVLC           = @{ Id = "VideoLAN.VLC";                Name = "VLC" }
    chkSpotify       = @{ Id = "Spotify.Spotify";             Name = "Spotify" }
    chkOBS           = @{ Id = "OBSProject.OBSStudio";       Name = "OBS Studio" }
    chkAudacity      = @{ Id = "Audacity.Audacity";           Name = "Audacity" }
    chkGIMP          = @{ Id = "GIMP.GIMP";                   Name = "GIMP" }
    chkHandBrake     = @{ Id = "HandBrake.HandBrake";        Name = "HandBrake" }
    chkKDEnlive      = @{ Id = "KDE.Kdenlive";               Name = "Kdenlive" }
    chkShareX        = @{ Id = "ShareX.ShareX";               Name = "ShareX" }
    chkIrfanView     = @{ Id = "IrfanSkiljan.IrfanView";     Name = "IrfanView" }

    # Documents
    chkLibreOffice   = @{ Id = "TheDocumentFoundation.LibreOffice"; Name = "LibreOffice" }
    chkAdobeReader   = @{ Id = "Adobe.Acrobat.Reader.64-bit"; Name = "Adobe Reader" }
    chkSumatraPDF    = @{ Id = "SumatraPDF.SumatraPDF";      Name = "Sumatra PDF" }
    chkObsidian      = @{ Id = "Obsidian.Obsidian";           Name = "Obsidian" }
    chkNotion        = @{ Id = "Notion.Notion";               Name = "Notion" }

    # Utilities
    "chk7Zip"        = @{ Id = "7zip.7zip";                   Name = "7-Zip" }
    chkWinRAR        = @{ Id = "RARLab.WinRAR";               Name = "WinRAR" }
    chkEverything    = @{ Id = "voidtools.Everything";        Name = "Everything" }
    chkPowerToys     = @{ Id = "Microsoft.PowerToys";         Name = "PowerToys" }
    chkTreeSize      = @{ Id = "JAMSoftware.TreeSize.Free";   Name = "TreeSize Free" }
    chkBitwarden     = @{ Id = "Bitwarden.Bitwarden";        Name = "Bitwarden" }
    chkKeePass       = @{ Id = "DominikReichl.KeePass";      Name = "KeePass" }
    chkqBittorrent   = @{ Id = "qBittorrent.qBittorrent";    Name = "qBittorrent" }
    chkWireshark     = @{ Id = "WiresharkFoundation.Wireshark"; Name = "Wireshark" }
    chkCPUZ          = @{ Id = "CPUID.CPU-Z";                Name = "CPU-Z" }
    chkHWiNFO        = @{ Id = "REALiX.HWiNFO";              Name = "HWiNFO" }

    # Gaming
    chkSteam         = @{ Id = "Valve.Steam";                 Name = "Steam" }
    chkEpic          = @{ Id = "EpicGames.EpicGamesLauncher"; Name = "Epic Games" }
    chkEAApp         = @{ Id = "ElectronicArts.EADesktop";    Name = "EA App" }
    chkGOG           = @{ Id = "GOG.Galaxy";                  Name = "GOG Galaxy" }
}

# ============================================================
# BLOATWARE APP MAP
# ============================================================
$BloatwareMap = @{
    dbBingNews       = "Microsoft.BingNews"
    dbBingWeather    = "Microsoft.BingWeather"
    dbGetHelp        = "Microsoft.GetHelp"
    dbGetStarted     = "Microsoft.Getstarted"
    dbMaps           = "Microsoft.WindowsMaps"
    dbFeedbackHub    = "Microsoft.WindowsFeedbackHub"
    dbPeople         = "Microsoft.People"
    dbSolitaire      = "Microsoft.MicrosoftSolitaireCollection"
    dbMixedReality   = "Microsoft.MixedReality.Portal"
    dbOneNote        = "Microsoft.Office.OneNote"
    dbSkype          = "Microsoft.SkypeApp"
    dbYourPhone      = "Microsoft.YourPhone"
    dbMail           = "microsoft.windowscommunicationsapps"
    dbGrooveMusic    = "Microsoft.ZuneMusic"
    dbTodoList       = "Microsoft.Todos"
    dbPowerAutomate  = "Microsoft.PowerAutomateDesktop"
    dbClipchamp      = "Clipchamp.Clipchamp"
    dbNews           = "Microsoft.News"
    dbOfficeHub      = "Microsoft.MicrosoftOfficeHub"
    dbZuneVideo      = "Microsoft.ZuneVideo"
    dbCortana        = "Microsoft.549981C3F5F10"
    dbTeamsConsumer  = "MicrosoftTeams"
    dbXboxApps       = "Microsoft.Xbox*"
    dbCamera         = "Microsoft.WindowsCamera"
    dbAlarms         = "Microsoft.WindowsAlarms"
}

# ============================================================
# EVENT HANDLERS
# ============================================================

# ── INSTALL TAB ──

$btnInstallSelected.Add_Click({
    if (-not (Ensure-WinGet)) { return }

    $selectedApps = @()
    foreach ($key in $PackageMap.Keys) {
        $ctrl = $window.FindName($key)
        if ($ctrl -and $ctrl.IsChecked) {
            $selectedApps += @{ Key = $key; Id = $PackageMap[$key].Id; Name = $PackageMap[$key].Name }
        }
    }

    if ($selectedApps.Count -eq 0) {
        [System.Windows.MessageBox]::Show("No apps selected!", "Info", "OK", "Information")
        return
    }

    $window.IsEnabled = $false
    Show-Progress 0

    $total = $selectedApps.Count
    $success = 0; $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $app = $selectedApps[$i]
        $pct = [math]::Round((($i + 1) / $total) * 100)
        Show-Progress $pct
        Update-Status "📦 [$($i+1)/$total] Installing $($app.Name)..."

        if (Install-WithWinGet -PackageId $app.Id -Name $app.Name) {
            $success++
        } else {
            $failed++
        }
    }

    Hide-Progress
    $window.IsEnabled = $true
    Update-Status "✅ Done! $success installed, $failed failed out of $total"
    [System.Windows.MessageBox]::Show(
        "Installation Complete!`n`n✅ Success: $success`n❌ Failed: $failed`nTotal: $total",
        "Install Results", "OK", "Information")
})

$btnSelectAll.Add_Click({
    foreach ($key in $PackageMap.Keys) {
        $ctrl = $window.FindName($key)
        if ($ctrl) { $ctrl.IsChecked = $true }
    }
})

$btnDeselectAll.Add_Click({
    foreach ($key in $PackageMap.Keys) {
        $ctrl = $window.FindName($key)
        if ($ctrl) { $ctrl.IsChecked = $false }
    }
})

$btnUpdateAll.Add_Click({
    if (-not (Ensure-WinGet)) { return }
    Update-Status "🔄 Updating all installed applications..."
    $window.IsEnabled = $false
    Start-Process powershell -ArgumentList "-Command winget upgrade --all --accept-package-agreements --accept-source-agreements" -Wait
    $window.IsEnabled = $true
    Update-Status "✅ All updates complete!"
})

# ── TWEAKS TAB ──

$btnApplyTweaks.Add_Click({
    $window.IsEnabled = $false
    $applied = 0

    # Telemetry
    if ($twkDisableTelemetry.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
        Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0
        Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
        $applied++
    }

    # Cortana
    if ($twkDisableCortana.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0
        $applied++
    }

    # Game Bar
    if ($twkDisableGameBar.IsChecked) {
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0
        Set-RegistryValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" 0
        $applied++
    }

    # Hibernation
    if ($twkDisableHibernation.IsChecked) {
        powercfg -h off
        $applied++
    }

    # High Performance
    if ($twkPowerHighPerf.IsChecked) {
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        $applied++
    }

    # Ultimate Performance
    if ($twkUltimatePerf.IsChecked) {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
        $applied++
    }

    # Disable System Restore
    if ($twkDisableSysRestore.IsChecked) {
        Disable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        $applied++
    }

    # Disable Indexing
    if ($twkDisableIndexing.IsChecked) {
        Stop-Service WSearch -Force -ErrorAction SilentlyContinue
        Set-Service WSearch -StartupType Disabled -ErrorAction SilentlyContinue
        $applied++
    }

    # Disable Prefetch/Superfetch
    if ($twkDisablePrefetch.IsChecked) {
        Stop-Service SysMain -Force -ErrorAction SilentlyContinue
        Set-Service SysMain -StartupType Disabled -ErrorAction SilentlyContinue
        $applied++
    }

    # Visual Performance
    if ($twkVisualPerf.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2
        $applied++
    }

    # Location
    if ($twkDisableLocation.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" 1
        $applied++
    }

    # Advertising ID
    if ($twkDisableAds.IsChecked) {
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
        $applied++
    }

    # Wi-Fi Sense
    if ($twkDisableWiFiSense.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" "Value" 0
        $applied++
    }

    # Feedback
    if ($twkDisableFeedback.IsChecked) {
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" 0
        $applied++
    }

    # Map Downloads
    if ($twkDisableMapUpdates.IsChecked) {
        Set-RegistryValue "HKLM:\SYSTEM\Maps" "AutoUpdateEnabled" 0
        $applied++
    }

    # Error Reporting
    if ($twkDisableErrorReporting.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" 1
        $applied++
    }

    # Activity History
    if ($twkDisableActivityHistory.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0
        $applied++
    }

    # Cloud Clipboard
    if ($twkDisableClipboardHistory.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "AllowCrossDeviceClipboard" 0
        $applied++
    }

    # Diagnostic Data
    if ($twkDisableDiagnostic.IsChecked) {
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" "ShowedToastAtLevel" 1
        $applied++
    }

    # Tips & Suggestions
    if ($twkDisableTips.IsChecked) {
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0
        Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SoftLandingEnabled" 0
        $applied++
    }

    # Show File Extensions
    if ($twkShowFileExt.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0
        $applied++
    }

    # Show Hidden Files
    if ($twkShowHidden.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1
        $applied++
    }

    # Taskbar Alignment Left (Win 11)
    if ($twkTaskbarLeft.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAl" 0
        $applied++
    }

    # Disable Widgets (Win 11)
    if ($twkDisableWidgets.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 0
        $applied++
    }

    # Disable Chat (Win 11)
    if ($twkDisableChat.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 0
        $applied++
    }

    # Classic Right-Click (Win 11)
    if ($twkClassicContext.IsChecked) {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value "" -Force
        $applied++
    }

    # Disable Startup Delay
    if ($twkDisableStartupDelay.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" 0
        $applied++
    }

    # Disable News & Interests
    if ($twkDisableNewsFeeds.IsChecked) {
        Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" 0
        $applied++
    }

    # Dark Mode
    if ($twkDarkMode.IsChecked) {
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
        Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
        $applied++
    }

    # Disable Mouse Acceleration
    if ($twkDisableMouseAccel.IsChecked) {
        Set-RegistryValue "HKCU:\Control Panel\Mouse" "MouseSpeed" "0" -Type String
        Set-RegistryValue "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0" -Type String
        Set-RegistryValue "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0" -Type String
        $applied++
    }

    # NumLock On at Startup
    if ($twkNumLockOn.IsChecked) {
        Set-RegistryValue "HKU:\.DEFAULT\Control Panel\Keyboard" "InitialKeyboardIndicators" "2" -Type String
        $applied++
    }

    $window.IsEnabled = $true
    Update-Status "✅ Applied $applied tweaks! Some may require restart."
    [System.Windows.MessageBox]::Show(
        "Applied $applied tweaks successfully!`n`nSome changes may require a restart to take effect.",
        "Tweaks Applied", "OK", "Information")
})

$btnRecommended.Add_Click({
    $recommended = @(
        $twkDisableTelemetry, $twkDisableCortana, $twkDisableAds,
        $twkDisableFeedback, $twkDisableErrorReporting, $twkDisableTips,
        $twkShowFileExt, $twkDisableActivityHistory, $twkDarkMode,
        $twkDisableLocation, $twkDisableGameBar, $twkDisableNewsFeeds,
        $twkDisableStartupDelay
    )
    $recommended | ForEach-Object { if ($_) { $_.IsChecked = $true } }
    Update-Status "✅ Recommended tweaks selected"
})

$btnDeselectTweaks.Add_Click({
    $tweakCheckboxes = @(
        $twkDisableTelemetry, $twkDisableCortana, $twkDisableGameBar,
        $twkDisableHibernation, $twkPowerHighPerf, $twkUltimatePerf,
        $twkDisableSysRestore, $twkDisableIndexing, $twkDisablePrefetch,
        $twkVisualPerf, $twkDisableLocation, $twkDisableAds,
        $twkDisableWiFiSense, $twkDisableFeedback, $twkDisableMapUpdates,
        $twkDisableErrorReporting, $twkDisableActivityHistory,
        $twkDisableClipboardHistory, $twkDisableDiagnostic, $twkDisableTips,
        $twkShowFileExt, $twkShowHidden, $twkTaskbarLeft, $twkDisableWidgets,
        $twkDisableChat, $twkClassicContext, $twkDisableStartupDelay,
        $twkDisableNewsFeeds, $twkDarkMode, $twkDisableMouseAccel, $twkNumLockOn
    )
    $tweakCheckboxes | ForEach-Object { if ($_) { $_.IsChecked = $false } }
})

$btnRestoreDefaults.Add_Click({
    $confirm = [System.Windows.MessageBox]::Show(
        "This will attempt to restore many settings to Windows defaults.`nContinue?",
        "Restore Defaults", "YesNo", "Warning")
    if ($confirm -ne "Yes") { return }

    $window.IsEnabled = $false
    Update-Status "↩️ Restoring defaults..."

    Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 3
    Set-Service DiagTrack -StartupType Automatic -ErrorAction SilentlyContinue
    Start-Service DiagTrack -ErrorAction SilentlyContinue

    Remove-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" -ErrorAction SilentlyContinue

    Set-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 1
    Set-RegistryValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 1

    Set-Service SysMain -StartupType Automatic -ErrorAction SilentlyContinue
    Start-Service SysMain -ErrorAction SilentlyContinue

    Set-Service WSearch -StartupType Automatic -ErrorAction SilentlyContinue
    Start-Service WSearch -ErrorAction SilentlyContinue

    Remove-Item "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Force -ErrorAction SilentlyContinue
    Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAl" 1
    Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 1
    Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 1

    Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 1
    Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 1

    $window.IsEnabled = $true
    Update-Status "✅ Defaults restored. Restart recommended."
    [System.Windows.MessageBox]::Show("Defaults restored! Please restart your computer.", "Done", "OK", "Information")
})

# ── DEBLOAT TAB ──

$btnDebloat.Add_Click({
    $toRemove = @()
    foreach ($key in $BloatwareMap.Keys) {
        $ctrl = $window.FindName($key)
        if ($ctrl -and $ctrl.IsChecked) {
            $toRemove += @{ Key = $key; Package = $BloatwareMap[$key] }
        }
    }

    if ($dbDisableOneDrive -and $dbDisableOneDrive.IsChecked) {
        $toRemove += @{ Key = "dbDisableOneDrive"; Package = "OneDrive" }
    }

    if ($toRemove.Count -eq 0) {
        [System.Windows.MessageBox]::Show("No apps selected for removal!", "Info", "OK", "Information")
        return
    }

    $confirm = [System.Windows.MessageBox]::Show(
        "Remove $($toRemove.Count) selected app(s)?`nThis action may not be easily reversible.",
        "Confirm Removal", "YesNo", "Warning")
    if ($confirm -ne "Yes") { return }

    $window.IsEnabled = $false
    Show-Progress 0
    $total = $toRemove.Count
    $removed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $item = $toRemove[$i]
        $pct = [math]::Round((($i + 1) / $total) * 100)
        Show-Progress $pct

        if ($item.Key -eq "dbDisableOneDrive") {
            Update-Status "🗑️ Removing OneDrive..."
            taskkill /f /im OneDrive.exe 2>$null
            if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
                & "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall /quiet
            } elseif (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
                & "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall /quiet
            }
            $removed++
        } elseif ($item.Key -eq "dbRemoveEdge") {
            Update-Status "🗑️ Attempting to remove Edge..."
            winget uninstall "Microsoft Edge" --accept-source-agreements --silent 2>$null
            $removed++
        } else {
            Update-Status "🗑️ Removing $($item.Package)..."
            try {
                Get-AppxPackage -Name $item.Package -AllUsers -ErrorAction SilentlyContinue |
                    Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
                Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue |
                    Where-Object { $_.PackageName -like "*$($item.Package)*" } |
                    Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
                $removed++
            } catch {
                Write-Warning "Failed to remove $($item.Package)"
            }
        }
    }

    Hide-Progress
    $window.IsEnabled = $true
    Update-Status "✅ Removed $removed/$total apps"
    [System.Windows.MessageBox]::Show(
        "Debloat Complete!`n`n🗑️ Removed: $removed / $total",
        "Debloat Results", "OK", "Information")
})

$btnSafeDebloat.Add_Click({
    $safe = @(
        $dbBingNews, $dbBingWeather, $dbGetHelp, $dbGetStarted,
        $dbFeedbackHub, $dbPeople, $dbSolitaire, $dbMixedReality,
        $dbSkype, $dbGrooveMusic, $dbTodoList, $dbPowerAutomate,
        $dbClipchamp, $dbNews, $dbOfficeHub, $dbZuneVideo,
        $dbTeamsConsumer, $dbMaps
    )
    $safe | ForEach-Object { if ($_) { $_.IsChecked = $true } }
    Update-Status "✅ Safe-to-remove apps selected"
})

$btnDeselectDebloat.Add_Click({
    foreach ($key in $BloatwareMap.Keys) {
        $ctrl = $window.FindName($key)
        if ($ctrl) { $ctrl.IsChecked = $false }
    }
    if ($dbDisableOneDrive) { $dbDisableOneDrive.IsChecked = $false }
    if ($dbRemoveEdge) { $dbRemoveEdge.IsChecked = $false }
})

# ── SYSTEM TOOLS TAB ──

$window.Add_Loaded({
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
        $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
        $gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
        $diskFree = [math]::Round($disk.FreeSpace / 1GB, 1)
        $diskTotal = [math]::Round($disk.Size / 1GB, 1)
        $uptime = (Get-Date) - $os.LastBootUpTime

        $info = @"
🪟 OS:        $($os.Caption) $($os.OSArchitecture)
📋 Build:     $($os.BuildNumber)
💻 Computer:  $($env:COMPUTERNAME)
👤 User:      $($env:USERNAME)

🔲 CPU:       $($cpu.Name)
   Cores:     $($cpu.NumberOfCores) cores / $($cpu.NumberOfLogicalProcessors) threads
🧠 RAM:       $ram GB
🎮 GPU:       $gpu

💿 C: Drive:  $diskFree GB free / $diskTotal GB total
⏱️ Uptime:    $([math]::Floor($uptime.TotalDays))d $($uptime.Hours)h $($uptime.Minutes)m
"@
        $txtSystemInfo.Text = $info
    } catch {
        $txtSystemInfo.Text = "Error loading system info: $($_.Exception.Message)"
    }
})

$btnDiskCleanup.Add_Click({
    Update-Status "🧹 Opening Disk Cleanup..."
    Start-Process cleanmgr -Verb RunAs
})

$btnDefrag.Add_Click({
    Update-Status "💿 Opening Defragment..."
    Start-Process dfrgui
})

$btnSFC.Add_Click({
    Update-Status "🔍 Running SFC /scannow..."
    Start-Process powershell -ArgumentList "-Command sfc /scannow; Read-Host 'Press Enter to close'" -Verb RunAs
})

$btnDISM.Add_Click({
    Update-Status "🛠️ Running DISM..."
    Start-Process powershell -ArgumentList "-Command DISM /Online /Cleanup-Image /RestoreHealth; Read-Host 'Press Enter to close'" -Verb RunAs
})

$btnFlushDNS.Add_Click({
    ipconfig /flushdns
    Update-Status "✅ DNS Cache Flushed!"
    [System.Windows.MessageBox]::Show("DNS Cache has been flushed!", "Done", "OK", "Information")
})

$btnClearTemp.Add_Click({
    Update-Status "🗂️ Clearing temp files..."
    $paths = @($env:TEMP, "C:\Windows\Temp", "C:\Windows\Prefetch")
    $totalRemoved = 0
    foreach ($path in $paths) {
        if (Test-Path $path) {
            $files = Get-ChildItem $path -Recurse -Force -ErrorAction SilentlyContinue
            $totalRemoved += $files.Count
            $files | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    Update-Status "✅ Cleaned ~$totalRemoved temp files!"
    [System.Windows.MessageBox]::Show("Cleaned approximately $totalRemoved temporary files!", "Done", "OK", "Information")
})

$btnResetNetwork.Add_Click({
    $confirm = [System.Windows.MessageBox]::Show(
        "This will reset all network adapters. You may lose connectivity temporarily. Continue?",
        "Reset Network", "YesNo", "Warning")
    if ($confirm -ne "Yes") { return }
    Update-Status "📡 Resetting network..."
    netsh winsock reset
    netsh int ip reset
    ipconfig /flushdns
    ipconfig /release
    ipconfig /renew
    Update-Status "✅ Network reset! Restart recommended."
    [System.Windows.MessageBox]::Show("Network has been reset. Please restart your computer.", "Done", "OK", "Information")
})

$btnDeviceManager.Add_Click({ Start-Process devmgmt.msc })
$btnTaskMgr.Add_Click({ Start-Process taskmgr })
$btnServices.Add_Click({ Start-Process services.msc })
$btnEventViewer.Add_Click({ Start-Process eventvwr.msc })
$btnRegedit.Add_Click({ Start-Process regedit })

$btnActivateWin.Add_Click({
    $confirm = [System.Windows.MessageBox]::Show(
        "This will attempt to activate Windows using Microsoft Activation Scripts (MAS).`nContinue?",
        "Activate Windows", "YesNo", "Question")
    if ($confirm -ne "Yes") { return }
    Update-Status "🔑 Running Windows Activation..."
    Start-Process powershell -ArgumentList "-Command irm https://get.activated.win | iex" -Verb RunAs
})

$btnWindowsUpdate.Add_Click({ Start-Process ms-settings:windowsupdate })

$btnCreateRestore.Add_Click({
    Update-Status "💾 Creating restore point..."
    try {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description "Ultimate Utility Restore Point" -RestorePointType MODIFY_SETTINGS
        Update-Status "✅ Restore point created!"
        [System.Windows.MessageBox]::Show("System restore point created successfully!", "Done", "OK", "Information")
    } catch {
        [System.Windows.MessageBox]::Show("Failed to create restore point: $($_.Exception.Message)", "Error", "OK", "Error")
    }
})

$btnWSL.Add_Click({
    Update-Status "🐧 Installing WSL..."
    Start-Process powershell -ArgumentList "-Command wsl --install; Read-Host 'Press Enter to close'" -Verb RunAs
})

$btnHyperV.Add_Click({
    Update-Status "📦 Enabling Hyper-V..."
    Start-Process powershell -ArgumentList "-Command Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart; Read-Host 'Press Enter to close'" -Verb RunAs
})

$btnSandbox.Add_Click({
    Update-Status "🏖️ Enabling Windows Sandbox..."
    Start-Process powershell -ArgumentList "-Command Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM' -All -NoRestart; Read-Host 'Press Enter to close'" -Verb RunAs
})

$btnDotNet.Add_Click({
    if (-not (Ensure-WinGet)) { return }
    Update-Status "📘 Installing .NET Runtimes..."
    Start-Process powershell -ArgumentList "-Command winget install Microsoft.DotNet.DesktopRuntime.8 --accept-package-agreements --accept-source-agreements; winget install Microsoft.DotNet.DesktopRuntime.6 --accept-package-agreements --accept-source-agreements; Read-Host 'Press Enter'" -Verb RunAs
})

$btnVCRedist.Add_Click({
    if (-not (Ensure-WinGet)) { return }
    Update-Status "📕 Installing VC++ Redistributables..."
    Start-Process powershell -ArgumentList "-Command winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements; winget install Microsoft.VCRedist.2015+.x86 --accept-package-agreements --accept-source-agreements; Read-Host 'Press Enter'" -Verb RunAs
})

$btnDirectX.Add_Click({
    Update-Status "🎮 Opening DirectX installer..."
    Start-Process "https://www.microsoft.com/en-us/download/details.aspx?id=35"
})

$btnBatteryReport.Add_Click({
    $reportPath = "$env:USERPROFILE\Desktop\battery-report.html"
    powercfg /batteryreport /output $reportPath
    if (Test-Path $reportPath) {
        Start-Process $reportPath
        Update-Status "✅ Battery report saved to Desktop"
    }
})

$btnPowerCfg.Add_Click({ Start-Process powercfg.cpl })

$btnCheckHealth.Add_Click({
    Update-Status "🏥 Running full health check..."
    $script = @"
Write-Host '========================================' -ForegroundColor Cyan
Write-Host '  FULL SYSTEM HEALTH CHECK' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
Write-Host ''
Write-Host '[1/3] Running SFC /scannow...' -ForegroundColor Yellow
sfc /scannow
Write-Host ''
Write-Host '[2/3] Running DISM RestoreHealth...' -ForegroundColor Yellow
DISM /Online /Cleanup-Image /RestoreHealth
Write-Host ''
Write-Host '[3/3] Running chkdsk (read-only)...' -ForegroundColor Yellow
chkdsk C: /scan
Write-Host ''
Write-Host '========================================' -ForegroundColor Green
Write-Host '  HEALTH CHECK COMPLETE!' -ForegroundColor Green
Write-Host '========================================' -ForegroundColor Green
Read-Host 'Press Enter to close'
"@
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($script)
    $encoded = [Convert]::ToBase64String($bytes)
    Start-Process powershell -ArgumentList "-EncodedCommand $encoded" -Verb RunAs
})

$btnExportConfig.Add_Click({
    $saveDlg = New-Object System.Windows.Forms.SaveFileDialog
    $saveDlg.Filter = "Text Files (*.txt)|*.txt"
    $saveDlg.FileName = "SystemConfig_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    if ($saveDlg.ShowDialog() -eq "OK") {
        $config = @"
============================================
  SYSTEM CONFIGURATION EXPORT
  Date: $(Get-Date)
============================================

--- OS INFO ---
$((Get-CimInstance Win32_OperatingSystem | Format-List * | Out-String))

--- CPU ---
$((Get-CimInstance Win32_Processor | Format-List Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed | Out-String))

--- RAM ---
$((Get-CimInstance Win32_PhysicalMemory | Format-Table Manufacturer, Capacity, Speed, PartNumber | Out-String))

--- GPU ---
$((Get-CimInstance Win32_VideoController | Format-List Name, DriverVersion, AdapterRAM | Out-String))

--- DISKS ---
$((Get-CimInstance Win32_LogicalDisk | Format-Table DeviceID, FileSystem, @{N='Size(GB)';E={[math]::Round($_.Size/1GB,1)}}, @{N='Free(GB)';E={[math]::Round($_.FreeSpace/1GB,1)}} | Out-String))

--- NETWORK ---
$((Get-NetAdapter | Where-Object Status -eq 'Up' | Format-Table Name, InterfaceDescription, LinkSpeed | Out-String))

--- INSTALLED PROGRAMS (via WinGet) ---
$((winget list 2>$null | Out-String))
"@
        $config | Out-File $saveDlg.FileName -Encoding UTF8
        Update-Status "✅ Config exported to $($saveDlg.FileName)"
        [System.Windows.MessageBox]::Show("Configuration exported successfully!", "Done", "OK", "Information")
    }
})

# ============================================================
# SHOW WINDOW
# ============================================================
$window.ShowDialog() | Out-Null