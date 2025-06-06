console.log("Script loaded");

Java.perform(function () {
    console.log("Inside Java.perform");

    var context = Java.use("android.app.ActivityThread").currentApplication().getApplicationContext();
    var Toast = Java.use("android.widget.Toast");

    Java.scheduleOnMainThread(function () {
        console.log("Showing Toast");
        Toast.makeText(context, "Hello dari Frida Gadget!", Toast.LENGTH_LONG.value).show();
    });
});
