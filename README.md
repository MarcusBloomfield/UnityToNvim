# Unity to Neovim Integration

This setup allows Unity to open files in Neovim using remote functionality, which opens files in new tabs of an existing Neovim instance rather than creating new instances.

## Setup Instructions

### 1. Configure Unity External Editor

In Unity, go to:
- **Edit** → **Preferences** → **External Tools**
- Set **External Script Editor** to: `C:\Users\marcu\Documents\UnityToNvim\UnityToNvim.bat`

### 2. Usage

Once configured:
1. Double-click any script file in Unity
2. The file will automatically:
   - If no Neovim server exists: Start a new Neovim instance with the file opened normally, and enable remote listening for future files
   - If Neovim server exists: Open the file in a new tab of the existing Neovim instance
3. No manual server setup required!

## How It Works

The `UnityToNvim.bat` script:
1. Checks if a Neovim instance is running on `localhost:6969`
2. If no instance exists:
   - Starts a new Neovim instance with `--listen localhost:6969`
   - Opens the file normally in the new Neovim window
   - Server is now ready for future remote connections
3. If instance exists:
   - Opens the file in a new tab using remote commands
4. Handles both scenarios automatically - no manual intervention needed

## Files

- `UnityToNvim.bat` - Main script that Unity calls to open files (handles everything automatically)
- `unity_debug.log` - Debug log showing what files are being opened

## Troubleshooting

If files aren't opening properly:
1. Check `unity_debug.log` for error messages
2. Verify the file paths in the batch script match your project structure
3. Ensure Neovim is installed and accessible from the command line

## Benefits

- **Fully automatic**: No need to manually start servers
- **Natural first experience**: First file opens normally in Neovim
- **Smart tab management**: Subsequent files open in new tabs
- Maintains your Neovim session and configuration
- Faster file opening
- Better workflow integration
- Clean tab-based organization of files
- Zero setup required after initial Unity configuration 