# macOS Backup Automation Kit  

## QuickStart  
1. Clone this repository:  
```bash
git clone https://github.com/Dfernandes9/macos-backup-automation-kit.git
cd macos-backup-automation-kit
```  
2. Copy the sample configuration file and edit it:  
```bash
cp config.sample.json config.json
nano config.json
```  
3. Make scripts executable:  
```bash
chmod +x time_machine_backup.sh icloud_consolidate.sh imazing_backup.sh verify_backup.sh run_backup.sh
```  
4. Run the backup pipeline:  
```bash
./run_backup.sh config.json
```  
- `time_machine_backup.sh` uses `tmutil` to enable Time Machine and start a backup.  
- `icloud_consolidate.sh` consolidates iCloud Drive to a local directory using rsync.  
- `imazing_backup.sh` runs iMazing CLI backups for connected devices.  
- `verify_backup.sh` checks that the backups exist.  

## Scheduling Backups with launchd  
1. Edit `com.macos.backupautomation.plist` to set the correct paths and copy it to `~/Library/LaunchAgents/`.  
2. Load the agent:  
```bash
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.macos.backupautomation.plist
launchctl kickstart -k gui/$(id -u)/com.macos.backupautomation
```  

## Troubleshooting  
- **Time Machine:** ensure the destination volume is writable and has enough space.  
- **iCloud consolidation:** only downloaded files are copied. Make sure the files are local in Finder before running.  
- **iMazing CLI not found:** install iMazing and ensure the CLI is in your PATH.  
- **Permissions:** use `chmod +x` on scripts; ensure you have read/write access to backup destinations.  
- **launchd not running:** use `launchctl list | grep backupautomation` to see status and reload the agent if necessary.  

## Rollback / Restore  
- Use Time Machine UI or Finder to restore files from your Time Machine backups.  
- To restore iCloud data, copy files from the iCloud backup destination back to `~/Library/Mobile Documents/com~apple~CloudDocs`.  
- To restore iMazing backups, open iMazing and restore from the specified backup directory.  

---  
This automation kit combines traditional Time Machine backups with consolidation of iCloud Drive and iOS backups. It's direct, simple and ready for future expansion. 
