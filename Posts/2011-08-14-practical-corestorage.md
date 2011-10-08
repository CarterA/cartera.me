# Practical Usage of CoreStorage #

Mac OS X Lion introduced a new low-level system for managing relationships between physical disks and file systems. Currently, the primary use of CoreStorage is to enable FileVault 2, Lion's full disk encryption system. CoreStorage includes low-level support for AES-XTS encryption, allowing a filesystem to be used on an encrypted volume without any modifications of the filesystem software. Therefor, any applications running on an encrypted volume don't need to change any of their behaviors to support the new FileVault features.  

The FileVault 2 UI (found in the Security and Privacy pane in System Preferences) only allows the encryption of the computer's startup disk. Though this may seem like a huge limitation, it is only in place at the UI level. There is absolutely nothing stopping you from using CoreStorage-based partitioning and encryption on external drives. This is proven by Apple's option in Time Machine preferences to encrypt the backup volume. Enabling that will convert your backup volume to the CoreStorage format and proceed to encrypt the entire contents of the drive.  

CoreStorage is sparsely documented, and the Disk Utility utility included in Mac OS X has not been updated to allow full manipulation of volumes using the new format. However, Lion does include a new subcommand for the `diskutil` command line utility called `coreStorage` (which can be abbreviated as `cs` to save time). The CoreStorage subcommand offers extensive new functionality, but only if you're willing to explore it a bit yourself. Reading through the CoreStorage section of the `diskutil` man page will help get you acquainted with the concepts, but playing with the various verbs is the easiest way to learn how everything works.  

<p class="divider">~</p>

[George](http://georgews.com) and I recently decided to set up offsite backups for each of our computers, synced up on occasion via [Sneakernet](http://en.wikipedia.org/wiki/Sneakernet). The device that is living at my house is a portable 500 GB FireWire hard drive. George's backup weighs in at about 230 GB, and mine at about 220. Because I could fit a copy of both of our computers on the drive, I decided to partition it so that I could have yet another backup of my own computer. I had just been reading about CoreStorage, so I took this opportunity to learn how the commands worked.  

My final goal was to have the 500 GB drive be split up into two halves. Each partition would have its own separate password for encryption, and would be mountable independent of the other. I succeeded in creating this setup with CoreStorage commands, though it wasn't always immediately obvious what to do.  

**Note: the steps described in this article will erase the contents of whatever physical volume you use. Continue at your own risk!**

The biggest unit of CoreStorage objects is the Logical Volume Group (LVG). An LVG represents a group of one or more Physical Volumes (PVs), and a corresponding group of Logical Volume Families (LVFs) which store their data on the PVs. Each LVF can contain one or more Logical Volume (LV). Encryption occurs at the LVF level, meaning if you want multiple volumes with different passwords, you need to break the LVG into multiple LVFs (one per password).  

Read the last paragraph again to make sure you understand how everything is laid out, as its fairly different from traditional disk partitioning.  

We start out by creating an LVG (the largest unit). LVGs are created with the `diskutil cs create` command. The command takes a name as the first parameter which will be used as the name for the LVG. This doesn't really matter, but I would suggest you name it something similar to what you will be naming the different volumes. For instance, both of my volumes contain the word "Mirror", so my LVG is called MirrorLVG.  

The next parameter for the command is an identifying piece of information for the Physical Volume you want to use to store the data of the LVG. You can provide more parameters afterwards, and each one will be treated as another PV to be added to the LVG. An identifying piece of information can be the current mount point of the drive (usually in /Volumes), the device identifier, or the BSD node name. Generally, the easiest one to use is the disk identifier. If you don't know what the identifier is for your drive, run `diskutil list` and find it in the far right column.  

The command I used to create my LVG for Mirror is as follows:  

    diskutil create MirrorLVG disk6

This creates an LVG called MirrorLVG using disk6 (the identifier for my external hard drive) as a PV.  

Next up are the LVFs. CoreStorage will create LVFs automatically as you add LVs, so we can actually skip straight to adding the volumes themselves. The next command requires the UUID of the LVG we just created. You can find the UUID by running `diskutil cs list` and looking for your LVG. Next to the words "Logical Volume Group" should be a long string of numbers and letters: that's the UUID.  

My original goal was to create two partitions, which means two commands. Here's the first one:  

    diskutil cs createVolume LVG-UUID jhfs+ "Mirror - Carter" 249G -passphrase

Let's dissect the arguments here: the first is the UUID of the newly created LVG. The second parameter is the filesystem I want on the volume: jhfs+ represents a Journaled HFS+ filesystem. The `diskutil` man page has a list of all the other choices. Next is a name for the new volume. Make sure to quote it if it contains special characters or spaces! After the name is the size of the volume. In this case I am specifying 249 GB. The `diskutil` man page has more information about the size notation it uses. Finally, the `-passphrase` flag is specified, which causes `diskutil` to prompt for an encryption passphrase once it starts. Note that at this time there doesn't seem to be a way to enable encryption after a volume has been created, so enable it here while you can.

The second command is exactly the same, save for a different volume name. You can check your work by running `diskutil cs list` at any time.  

CoreStorage volumes can be resized on-the-fly using the `diskutil cs resizeVolume` command. Note that this command, while seemingly functional, is not documented in the man page. It takes two parameters: the UUID of the volume to be resized, and the target size. I have resized my two volumes multiple times, and it seems to work perfectly.  

CoreStorage is an extremely promising technology, and has the potential to replace Apple's RAID implementation and perhaps let them slowly break free from the dinosaur that is HFS. Hopefully Disk Utility will be updated in coming updates to OS X Lion to better take advantage of the features of CoreStorage. Until then, I hope you're comfortable on the command line!