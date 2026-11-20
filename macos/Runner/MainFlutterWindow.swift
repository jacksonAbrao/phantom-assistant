import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    // Barra de título integrada ao fundo do app
    self.titlebarAppearsTransparent = true
    self.titleVisibility = .hidden
    self.styleMask.insert(.fullSizeContentView)
    self.backgroundColor = NSColor(
      red: 0x14 / 255.0, green: 0x11 / 255.0, blue: 0x1C / 255.0, alpha: 1
    )

    RegisterGeneratedPlugins(registry: flutterViewController)
    super.awakeFromNib()
  }
}