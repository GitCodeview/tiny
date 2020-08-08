namespace WindowsServiceApp
{
    partial class ProjectInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.serviceAppProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.serviceAppInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // serviceAppProcessInstaller
            // 
            this.serviceAppProcessInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.serviceAppProcessInstaller.Password = null;
            this.serviceAppProcessInstaller.Username = null;
            // 
            // serviceAppInstaller
            // 
            this.serviceAppInstaller.Description = "Windows Service App Test Demo to Test the update service.";
            this.serviceAppInstaller.DisplayName = "App Service Test Demo for Windows";
            this.serviceAppInstaller.ServiceName = "AppServiceTest";
            this.serviceAppInstaller.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.serviceAppInstaller_AfterInstall);
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.serviceAppProcessInstaller,
            this.serviceAppInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller serviceAppProcessInstaller;
        private System.ServiceProcess.ServiceInstaller serviceAppInstaller;
    }
}