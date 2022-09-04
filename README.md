# Powershell Ping Test Script

> Ping Test Scripti ile windows task scheduler kullanarak belirli sayıda otomatik ping başlatabilirsiniz.
Bu script otomatik olarak zamanlanmış bir görev oluşturur. Belirtilen zamanda otomatik olarak başlar ve atılan pingleri loglamaktadır.

[Onur Yılmaz Blog Adresimden](https://onuryilmaz.blog/powershell-ping-test-araci/) detaylarını inceleyebilirsiniz.

["Config.xml"](Config.xml) dosyasında;

- TaskName = Task Scheduler'da görüntülenecek ismini,
- InstallFolderPath = Kurulum adresini,
- LogFolderPath = Log dosyasının adresini,
- IPTestCount = Atılacak ping adetini (Default 4'tür.)

belirleyebilirsiniz.

["IPTester_Install.cmd"](IPTester_Install.cmd) dosyası ile kurulum sağlayabilirsiniz.

["IPTester_Uninstall.cmd"](IPTester_Uninstall.cmd) dosyası ile kurulumu kaldırabilirsiniz.

Task Scheduler'da oluşacak tetikleyici zamanının belirlemesini ["IPTest.ps1"](IPTest.ps1) scriptinde yer alan 25. satırdan [Microsoft'un "ScheduledTasks" modülüne](https://docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger?view=windowsserver2022-ps) göre düzenleme sağlayabilirsiniz.

Bu script hiçbir garanti olmaksızın "OLDUĞU GİBİ" sağlanmaktadır. Kendi sorumluluğunuzda kullanınınız.
