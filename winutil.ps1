# ============================================================
# WEB-OPTIMIZED WINDOWS UTILITY
# ============================================================

# 1. Check for Administrator and STOP if not found
# (Running via IEX doesn't allow self-elevation easily)
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "CRITICAL: You MUST run PowerShell as Administrator first!"
    Write-Host "Please close this window, right-click PowerShell, and 'Run as Administrator'." -ForegroundColor Yellow
    return
}

# 2. Load necessary GUI components
try {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms
} catch {
    Write-Error "Failed to load GUI components."
    return
}

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

        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#e0e0e0"/>
            <Setter Property="FontSize" Value="12.5"/>
            <Setter Property="Margin" Value="5,4"/>
        </Style>

        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#16213e"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="#16213e" CornerRadius="8,8,0,0" Padding="15,10">
                            <ContentPresenter ContentSource="Header"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="tabBorder" Property="Background" Value="#e94560"/>
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

        <Border Grid.Row="0" Background="#0f3460" Padding="20,12">
            <TextBlock Text="⚡ alexzfernandez Utility" FontSize="22" FontWeight="Bold" Foreground="White"/>
        </Border>

        <TabControl Grid.Row="1" Background="#1a1a2e" BorderThickness="0" Margin="10">
            <TabItem Header="📦 Install Apps">
                <StackPanel Margin="20">
                    <TextBlock Text="App Installation via WinGet" FontSize="18" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                    <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                    <CheckBox x:Name="chkVSCode" Content="VS Code"/>
                    <Button x:Name="btnInstall" Content="Install Selected" Style="{StaticResource AccentButton}" Width="200" HorizontalAlignment="Left" Margin="0,20,0,0"/>
                </StackPanel>
            </TabItem>
            
            <TabItem Header="⚙️ Tweaks">
                <StackPanel Margin="20">
                     <Button x:Name="btnDark" Content="Enable Dark Mode" Style="{StaticResource ModernButton}" Width="200" HorizontalAlignment="Left"/>
                     <Button x:Name="btnExtensions" Content="Show File Extensions" Style="{StaticResource ModernButton}" Width="200" HorizontalAlignment="Left"/>
                </StackPanel>
            </TabItem>
        </TabControl>

        <StatusBar Grid.Row="2" Background="#0f3460">
            <TextBlock x:Name="txtStatus" Text=" Ready" Foreground="White"/>
        </StatusBar>
    </Grid>
</Window>
"@

# ============================================================
# LOGIC
# ============================================================
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

$btnInstall = $window.FindName("btnInstall")
$chk7Zip = $window.FindName("chk7Zip")
$chkChrome = $window.FindName("chkChrome")
$chkVSCode = $window.FindName("chkVSCode")
$btnDark = $window.FindName("btnDark")
$btnExtensions = $window.FindName("btnExtensions")
$txtStatus = $window.FindName("txtStatus")

$btnInstall.Add_Click({
    $txtStatus.Text = "Installing..."
    if ($chk7Zip.IsChecked) { winget install 7zip.7zip --silent }
    if ($chkChrome.IsChecked) { winget install Google.Chrome --silent }
    if ($chkVSCode.IsChecked) { winget install Microsoft.VisualStudioCode --silent }
    $txtStatus.Text = "Done!"
})

$btnDark.Add_Click({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
    $txtStatus.Text = "Dark Mode Applied!"
})

$btnExtensions.Add_Click({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
    Stop-Process -Name explorer -Force
    $txtStatus.Text = "Extensions Visible!"
})

$window.ShowDialog() | Out-Null
