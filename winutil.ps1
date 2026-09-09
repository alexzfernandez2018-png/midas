#Requires -RunAsAdministrator
# ============================================================
# MIDAS SYSTEM UTILITY
# Sleek Metallic Edition
# ============================================================

# ── Load Required Assemblies ──
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

try {
    # ── Admin Verification ──
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        [System.Windows.MessageBox]::Show("Administrator privileges required. Please launch PowerShell as Administrator.","MIDAS","OK","Warning") | Out-Null
        exit
    }

    # ============================================================
    # XAML GUI DEFINITION
    # ============================================================
    [xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="MIDAS"
    Height="720" Width="1080"
    WindowStartupLocation="CenterScreen"
    Background="#050403" Foreground="#e3dac9"
    ResizeMode="CanResizeWithGrip"
    FontFamily="Segoe UI">

    <Window.Resources>
        <Style x:Key="SleekButton" TargetType="Button">
            <Setter Property="Background" Value="#120e0a"/>
            <Setter Property="Foreground" Value="#c5a059"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="14,7"/>
            <Setter Property="Margin" Value="4"/>
            <Setter Property="BorderBrush" Value="#3d3118"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="3" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#241b10"/>
                                <Setter TargetName="border" Property="BorderBrush" Value="#c5a059"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="AccentButton" TargetType="Button" BasedOn="{StaticResource SleekButton}">
            <Setter Property="Background" Value="#2b200d"/>
            <Setter Property="Foreground" Value="#f2e6ce"/>
        </Style>

        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#b3a998"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Margin" Value="5,5"/>
        </Style>

        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#0c0906"/>
            <Setter Property="Foreground" Value="#705b30"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="Padding" Value="20,8"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="{TemplateBinding Background}"
                                BorderBrush="#241b0d" BorderThickness="1,1,1,0"
                                CornerRadius="3,3,0,0" Padding="{TemplateBinding Padding}">
                            <ContentPresenter ContentSource="Header" HorizontalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="tabBorder" Property="Background" Value="#17120a"/>
                                <Setter TargetName="tabBorder" Property="BorderBrush" Value="#c5a059"/>
                                <Setter Property="Foreground" Value="#c5a059"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid x:Name="MainGrid">
        <Grid.Background>
            <LinearGradientBrush x:Name="LiquidGoldBrush" StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#050403" Offset="0.0"/>
                <GradientStop Color="#140f08" Offset="0.2"/>
                <GradientStop Color="#302410" Offset="0.4"/>
                <GradientStop Color="#6e5424" Offset="0.5"/>
                <GradientStop Color="#302410" Offset="0.6"/>
                <GradientStop Color="#140f08" Offset="0.8"/>
                <GradientStop Color="#050403" Offset="1.0"/>
            </LinearGradientBrush>
        </Grid.Background>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#0a0805" BorderBrush="#241b0d" BorderThickness="0,0,0,1" Padding="20,12">
            <Grid>
                <TextBlock Text="MIDAS" FontSize="18" FontWeight="Bold" Foreground="#c5a059"/>
                <TextBlock Text="v3.0" FontSize="11" Foreground="#3d3118" HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="12">
            <TabItem Header="Applications">
                <Border Background="#0a0805" CornerRadius="0,3,3,3" BorderBrush="#241b0d" BorderThickness="1" Padding="16">
                    <Grid>
                        <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                        <ScrollViewer VerticalScrollBarVisibility="Auto">
                            <Grid>
                                <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0">
                                    <TextBlock Text="Browsers" FontSize="12.5" FontWeight="Bold" Foreground="#c5a059" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chkChrome" Content="Google Chrome"/><CheckBox x:Name="chkFirefox" Content="Mozilla Firefox"/>
                                    <CheckBox x:Name="chkBrave" Content="Brave Browser"/><CheckBox x:Name="chkEdge" Content="Microsoft Edge"/>
                                </StackPanel>
                                <StackPanel Grid.Column="1">
                                    <TextBlock Text="Developer" FontSize="12.5" FontWeight="Bold" Foreground="#c5a059" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chkVSCode" Content="VS Code"/><CheckBox x:Name="chkGit" Content="Git"/>
                                    <CheckBox x:Name="chkTerminal" Content="Terminal"/><CheckBox x:Name="chkPython" Content="Python"/>
                                </StackPanel>
                                <StackPanel Grid.Column="2">
                                    <TextBlock Text="Media" FontSize="12.5" FontWeight="Bold" Foreground="#c5a059" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chkVLC" Content="VLC"/><CheckBox x:Name="chkSpotify" Content="Spotify"/>
                                    <CheckBox x:Name="chkOBS" Content="OBS Studio"/><CheckBox x:Name="chkGIMP" Content="GIMP"/>
                                </StackPanel>
                                <StackPanel Grid.Column="3">
                                    <TextBlock Text="Utilities" FontSize="12.5" FontWeight="Bold" Foreground="#c5a059" Margin="5,4,5,8"/>
                                    <CheckBox x:Name="chk7Zip" Content="7-Zip"/><CheckBox x:Name="chkWinRAR" Content="WinRAR"/>
                                    <CheckBox x:Name="chkSteam" Content="Steam"/><CheckBox x:Name="chkBitwarden" Content="Bitwarden"/>
                                </StackPanel>
                            </Grid>
                        </ScrollViewer>
                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,14,0,0">
                            <Button x:Name="btnInstallApps" Content="Install Selected" Style="{StaticResource AccentButton}" Width="160"/>
                            <Button x:Name="btnSelectAllApps" Content="Select All" Style="{StaticResource SleekButton}" Width="110"/>
                            <Button x:Name="btnDeselectApps" Content="Clear" Style="{StaticResource SleekButton}" Width="110"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <TabItem Header="Tweaks">
                <Border Background="#0a0805" CornerRadius="0,3,3,3" BorderBrush="#241b0d" BorderThickness="1" Padding="16">
                    <Grid>
                        <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                        <StackPanel>
                            <CheckBox x:Name="twkHighPerf" Content="High Performance Power Plan"/>
                            <CheckBox x:Name="twkDisableTelemetry" Content="Disable Telemetry"/>
                            <CheckBox x:Name="twkDarkMode" Content="Enable Dark Mode"/>
                            <CheckBox x:Name="twkShowFileExt" Content="Show File Extensions"/>
                            <CheckBox x:Name="twkClassicRightClick" Content="Classic Context Menu (Win 11)"/>
                        </StackPanel>
                        <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,14,0,0">
                            <Button x:Name="btnApplyTweaks" Content="Apply Tweaks" Style="{StaticResource AccentButton}" Width="180"/>
                        </StackPanel>
                    </Grid>
                </Border>
            </TabItem>

            <TabItem Header="Tools">
                <Border Background="#0a0805" CornerRadius="0,3,3,3" BorderBrush="#241b0d" BorderThickness="1" Padding="16">
                   <WrapPanel>
                        <Button x:Name="btnSFC" Content="SFC Scan" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnDISM" Content="DISM Repair" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnFlushDNS" Content="Flush DNS" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnActivate" Content="Activate Windows" Style="{StaticResource AccentButton}"/>
                   </WrapPanel>
                </Border>
            </TabItem>
        </TabControl>

        <Border Grid.Row="2" Background="#0a0805" BorderBrush="#241b0d" BorderThickness="0,1,0,0" Padding="16,8">
            <TextBlock x:Name="txtStatus" Text="Ready" FontSize="11.5" Foreground="#705b30"/>
        </Border>
    </Grid>
</Window>
"@

    $reader = New-Object System.Xml.XmlNodeReader $XAML
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $liquidBrush = $window.FindName("LiquidGoldBrush")
    if ($liquidBrush) {
        $animStart = New-Object System.Windows.Media.Animation.PointAnimation
        $animStart.From = New-Object System.Windows.Point(0, 0)
        $animStart.To = New-Object System.Windows.Point(0.7, 0.4)
        $animStart.Duration = [TimeSpan]::FromSeconds(7)
        $animStart.AutoReverse = $true
        $animStart.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
        $liquidBrush.BeginAnimation([System.Windows.Media.LinearGradientBrush]::StartPointProperty, $animStart)
    }

    $window.FindName("btnSFC").Add_Click({ Start-Process powershell "-NoExit -Command sfc /scannow" -Verb RunAs })
    $window.FindName("btnActivate").Add_Click({ Start-Process powershell "-Command irm https://get.activated.win | iex" -Verb RunAs })
    $window.FindName("btnFlushDNS").Add_Click({ ipconfig /flushdns })
    
    $window.ShowDialog() | Out-Null

} catch {
    [System.Windows.MessageBox]::Show("Error: $_", "MIDAS")
}
