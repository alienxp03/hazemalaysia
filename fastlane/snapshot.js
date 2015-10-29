#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

target.delay(2)
target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);

//target.frontMostApp().mainWindow().buttons()["Allow location access"].tap();
//target.frontMostApp().alert().buttons()["Allow"].tap();

target.delay(1)
target.setLocation({ latitude: 3.157444, longitude: 101.711204 });

target.delay(1)
captureLocalizedScreenshot('0-MainScreen');

target.frontMostApp().tabBar().buttons()[1].tap();
captureLocalizedScreenshot('0-AllStatus');