# PhotoPickerDemo


#### Tag `ViewController_is_UIImagePickerDelegate`

The ViewController 
- creates an instance of UIImagePicker
- configures it to take a photo or to pick a photo from the library
- implements the UIImagePickerDelegate methods
- handles the UI interactions

#### Tag `class_WrappedImagePicker_in_own_file`

Dependencies on the `UIImagePicker` are confined to the class `WrappedImagePicker`.

The ViewController
- creates an instance of `WrappedImagePicker` which is the `UIImagePickerDelegate`
- calls `WrappedImagePicker` methods to take or pick a photo
- implements the `WrappedImagePickerDelegate` method that delivers the photo taken or picked
- handles the UI interactions



