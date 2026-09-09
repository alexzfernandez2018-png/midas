#Requires -RunAsAdministrator

# 1. Load Assemblies (Required for UI)
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

try {
    # 2. Admin Verification
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        [System.Windows.MessageBox]::Show("Administrator privileges required. Please launch PowerShell as Administrator.", "MIDAS")
        exit
    }

    # 3. XAML UI (Sleek Obsidian & Liquid Gold)
    [xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="MIDAS" Height="730" Width="1080" WindowStartupLocation="CenterScreen"
    Background="#050403" Foreground="#d4af37" ResizeMode="CanResizeWithGrip">
    
    <Window.Resources>
        <Style x:Key="SleekButton" TargetType="Button">
            <Setter Property="Background" Value="#120e0a"/>
            <Setter Property="Foreground" Value="#d4af37"/>
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

        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#b3a998"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Margin" Value="5,8"/>
        </Style>

        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#0c0906"/>
            <Setter Property="Foreground" Value="#705b30"/>
            <Setter Property="Padding" Value="25,10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border x:Name="tabBorder" Background="{TemplateBinding Background}"
                                BorderBrush="#241b0d" BorderThickness="1,1,1,0"
                                CornerRadius="3,3,0,0" Padding="{TemplateBinding Padding}">
                            <ContentPresenter ContentSource="Header"/>
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

    <Grid>
        <Grid.Background>
            <LinearGradientBrush x:Name="LiquidGold" StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#050403" Offset="0.0"/>
                <GradientStop Color="#1a140b" Offset="0.2"/>
                <GradientStop Color="#8c6d2d" Offset="0.5"/>
                <GradientStop Color="#1a140b" Offset="0.8"/>
                <GradientStop Color="#050403" Offset="1.0"/>
            </LinearGradientBrush>
        </Grid.Background>

        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#0a0805" BorderBrush="#241b0d" BorderThickness="0,0,0,1" Padding="25,15">
            <TextBlock Text="MIDAS" FontSize="22" FontWeight="Bold" Foreground="#c5a059"/>
        </Border>

        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="15">
            <TabItem Header="Applications">
                <Border Background="#0a0805" BorderBrush="#241b0d" BorderThickness="1" Padding="20">
                    <Grid>
                        <Grid.RowDefinitions><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                        <UniformGrid Columns="3">
                            <StackPanel>
                                <TextBlock Text="Browsers" FontWeight="Bold" Margin="0,0,0,10"/>
                                <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                                <CheckBox x:Name="chkFirefox" Content="Firefox"/>
                                <CheckBox x:Name="chkBrave" Content="Brave"/>
                            </StackPanel>
                            <StackPanel>
                                <TextBlock Text="Tools" FontWeight="Bold" Margin="0,0,0,10"/>
                                <CheckBox x:Name="chkVSCode" Content="VS Code"/>
                                <CheckBox x:Name="chkGit" Content="Git"/>
                                <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                            </StackPanel>
                            <StackPanel>
                                <TextBlock Text="Social" FontWeight="Bold" Margin="0,0,0,10"/>
                                <CheckBox x:Name="chkDiscord" Content="Discord"/>
                                <CheckBox x:Name="chkSteam" Content="Steam"/>
                                <CheckBox x:Name="chkSpotify" Content="Spotify"/>
                            </StackPanel>
                        </UniformGrid>
                        <Button x:Name="btnInstall" Grid.Row="1" Content="Install Selected" Style="{StaticResource SleekButton}" Width="200" HorizontalAlignment="Center" Margin="0,20,0,0"/>
                    </Grid>
                </Border>
            </TabItem>

            <TabItem Header="Tweaks">
                <Border Background="#0a0805" BorderBrush="#241b0d" BorderThickness="1" Padding="20">
                    <StackPanel>
                        <CheckBox x:Name="twkDark" Content="System Dark Mode" IsChecked="True"/>
                        <CheckBox x:Name="twkExt" Content="Show File Extensions" IsChecked="True"/>
                        <CheckBox x:Name="twkPerf" Content="High Performance Power Plan"/>
                        <CheckBox x:Name="twkClassic" Content="Classic Context Menu (Win 11)"/>
                        <Button x:Name="btnApply" Content="Apply Tweaks" Style="{StaticResource SleekButton}" Width="200" HorizontalAlignment="Left" Margin="0,20,0,0"/>
                    </StackPanel>
                </Border>
            </TabItem>

            <TabItem Header="Repairs">
                <Border Background="#0a0805" BorderBrush="#241b0d" BorderThickness="1" Padding="20">
                    <WrapPanel>
                        <Button x:Name="btnSFC" Content="SFC Scan" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnDISM" Content="DISM Repair" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnDNS" Content="Flush DNS" Style="{StaticResource SleekButton}"/>
                        <Button x:Name="btnAct" Content="Activate Windows" Style="{StaticResource SleekButton}" Background="#2b200d"/>
                    </WrapPanel>
                </Border>
            </TabItem>
        </TabControl>

        <Border Grid.Row="2" Background="#0a0805" BorderBrush="#241b0d" BorderThickness="0,1,0,0" Padding="15,10">
            <TextBlock x:Name="status" Text="Ready" FontSize="11" Foreground="#705b30"/>
        </Border>
    </Grid>
</Window>
"@

    # 4. Load Window
    $reader = New-Object System.Xml.XmlNodeReader $XAML
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # 5. Realistic Liquid Animation (Metallic Flow)
    $brush = $window.FindName("LiquidGold")
    $anim = New-Object System.Windows.Media.Animation.PointAnimation
    $anim.From = "0,0"
    $anim.To = "1,0.6"
    $anim.Duration = [TimeSpan]::FromSeconds(10)
    $anim.AutoReverse = $true
    $anim.RepeatBehavior = "Forever"
    $brush.BeginAnimation([System.Windows.Media.LinearGradientBrush]::StartPointProperty, $anim)

    # 6. Functional Logic
    $window.FindName("btnSFC").Add_Click({ Start-Process powershell "-NoExit -Command sfc /scannow" -Verb RunAs })
    $window.FindName("btnDNS").Add_Click({ ipconfig /flushdns; [System.Windows.MessageBox]::Show("DNS Flushed.", "MIDAS") })
    $window.FindName("btnAct").Add_Click({ Start-Process powershell "-Command irm https://get.activated.win | iex" -Verb RunAs })

    $window.FindName("btnInstall").Add_Click({
        $apps = @{ "chkChrome"="Google.Chrome"; "chkFirefox"="Mozilla.Firefox"; "chkVSCode"="Microsoft.VisualStudioCode"; "chk7Zip"="7zip.7zip"; "chkDiscord"="Discord.Discord"; "chkSteam"="Valve.Steam"; "chkSpotify"="Spotify.Spotify" }
        foreach($id in $apps.Keys) {
            if ($window.FindName($id).IsChecked) {
                winget install --id $apps[$id] --silent --accept-package-agreements
            }
        }
        [System.Windows.MessageBox]::Show("Task Complete.", "MIDAS")
    })

    $window.FindName("btnApply").Add_Click({
        if ($window.FindName("twkExt").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 }
        if ($window.FindName("twkDark").IsChecked) { 
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        }
        if ($window.FindName("twkClassic").IsChecked) {
            $path = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
            if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
            Set-ItemProperty -Path $path -Name "(Default)" -Value "" -Force
        }
        [System.Windows.MessageBox]::Show("Tweaks Applied. Restart explorer.exe to see changes.", "MIDAS")
    })

    $window.ShowDialog() | Out-Null

} catch {
    [System.Windows.MessageBox]::Show("Error: $_", "MIDAS")
}
