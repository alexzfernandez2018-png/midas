#Requires -RunAsAdministrator

# 1. Load Assemblies
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

try {
    # 2. Admin Check
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        [System.Windows.MessageBox]::Show("Please run PowerShell as Administrator.", "MIDAS")
        exit
    }

    # 3. XAML UI (Zero Emojis, Sleek Liquid Gold)
    [xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="MIDAS" Height="700" Width="1000" WindowStartupLocation="CenterScreen"
    Background="#050403" Foreground="#d4af37" ResizeMode="CanResizeWithGrip">
    <Window.Resources>
        <Style x:Key="SleekButton" TargetType="Button">
            <Setter Property="Background" Value="#1a160d"/>
            <Setter Property="Foreground" Value="#d4af37"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="10,5"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="BorderBrush" Value="#4a3b18"/>
        </Style>
    </Window.Resources>
    <Grid>
        <Grid.Background>
            <LinearGradientBrush x:Name="LiquidGold" StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#050403" Offset="0.0"/>
                <GradientStop Color="#3b2d13" Offset="0.5"/>
                <GradientStop Color="#050403" Offset="1.0"/>
            </LinearGradientBrush>
        </Grid.Background>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <Border Grid.Row="0" Background="#0d0b08" Padding="20,10" BorderBrush="#d4af37" BorderThickness="0,0,0,1">
            <TextBlock Text="MIDAS" FontSize="20" FontWeight="Bold" LetterSpacing="2"/>
        </Border>

        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="10">
            <TabItem Header="Applications">
                <UniformGrid Columns="2" Margin="20">
                    <CheckBox x:Name="chkChrome" Content="Google Chrome"/>
                    <CheckBox x:Name="chkVSCode" Content="VS Code"/>
                    <CheckBox x:Name="chk7Zip" Content="7-Zip"/>
                    <CheckBox x:Name="chkDiscord" Content="Discord"/>
                    <Button x:Name="btnInstall" Content="Install Selected" Style="{StaticResource SleekButton}" Grid.ColumnSpan="2"/>
                </UniformGrid>
            </TabItem>
            <TabItem Header="Tweaks">
                <StackPanel Margin="20">
                    <CheckBox x:Name="twkDark" Content="System Dark Mode"/>
                    <CheckBox x:Name="twkExt" Content="Show File Extensions"/>
                    <Button x:Name="btnApply" Content="Apply Tweaks" Style="{StaticResource SleekButton}"/>
                </StackPanel>
            </TabItem>
            <TabItem Header="Tools">
                <WrapPanel Margin="20">
                    <Button x:Name="btnSFC" Content="SFC Scan" Style="{StaticResource SleekButton}"/>
                    <Button x:Name="btnDNS" Content="Flush DNS" Style="{StaticResource SleekButton}"/>
                    <Button x:Name="btnAct" Content="Activate Windows" Style="{StaticResource SleekButton}"/>
                </WrapPanel>
            </TabItem>
        </TabControl>
        
        <Border Grid.Row="2" Background="#0d0b08" Padding="10">
            <TextBlock x:Name="status" Text="Ready" FontSize="10"/>
        </Border>
    </Grid>
</Window>
"@

    # 4. Initialize Window
    $reader = New-Object System.Xml.XmlNodeReader $XAML
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # 5. Background Animation (Liquid Movement)
    $brush = $window.FindName("LiquidGold")
    $anim = New-Object System.Windows.Media.Animation.PointAnimation
    $anim.From = "0,0"; $anim.To = "1,1"; $anim.Duration = [TimeSpan]::FromSeconds(5)
    $anim.AutoReverse = $true; $anim.RepeatBehavior = "Forever"
    $brush.BeginAnimation([System.Windows.Media.LinearGradientBrush]::StartPointProperty, $anim)

    # 6. Button Logic
    $window.FindName("btnSFC").Add_Click({ Start-Process powershell "-NoExit -Command sfc /scannow" -Verb RunAs })
    $window.FindName("btnDNS").Add_Click({ ipconfig /flushdns; [System.Windows.MessageBox]::Show("DNS Flushed", "MIDAS") })
    $window.FindName("btnAct").Add_Click({ Start-Process powershell "-Command irm https://get.activated.win | iex" -Verb RunAs })

    $window.FindName("btnInstall").Add_Click({
        if ($window.FindName("chk7Zip").IsChecked) { winget install 7zip.7zip }
        if ($window.FindName("chkChrome").IsChecked) { winget install Google.Chrome }
        [System.Windows.MessageBox]::Show("Process Finished", "MIDAS")
    })

    $window.ShowDialog() | Out-Null

} catch {
    [System.Windows.MessageBox]::Show("Critical Error: $_", "MIDAS")
}
