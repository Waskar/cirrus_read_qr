package com.example.cirrusreadqr;

import android.os.Environment;
import android.support.annotation.VisibleForTesting;

import java.io.File;

import android.content.Intent;
import android.os.Environment;
import android.support.annotation.VisibleForTesting;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import java.io.File;

import javax.xml.transform.Result;

/** CirrusReadQrPlugin */
public class CirrusReadQrPlugin implements MethodChannel.MethodCallHandler  {
  /** Plugin registration. */

  private static final String CHANNEL = "cirrus_read_qr";
  private final PluginRegistry.Registrar registrar;
  private final ImagePickerDelegate delegate;

  public static void registerWith(PluginRegistry.Registrar registrar) {

    final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
    final File externalFilesDirectory = registrar.activity().getExternalFilesDir(Environment.DIRECTORY_PICTURES);
    final ExifDataCopier exifDataCopier = new ExifDataCopier();
    final ImageResizer imageResizer = new ImageResizer(externalFilesDirectory, exifDataCopier);

    final ImagePickerDelegate delegate = new ImagePickerDelegate(registrar.activity(), externalFilesDirectory, imageResizer);


    registrar.addActivityResultListener(delegate);
    registrar.addRequestPermissionsResultListener(delegate);

    final CirrusReadQrPlugin instance = new CirrusReadQrPlugin (registrar, delegate);

    channel.setMethodCallHandler(instance);
  }

  @VisibleForTesting
  CirrusReadQrPlugin(PluginRegistry.Registrar registrar, ImagePickerDelegate delegate) {
    this.registrar = registrar;
    this.delegate = delegate;
  }

  @Override
  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
    if (registrar.activity() == null) {
      result.error("no_activity", "image_picker requiere una actividad en primer plano.", null);
      return;
    }
    if (call.method.equals("pickImage")) {
      delegate.chooseImageFromGallery(call, result);
      //delegate.qr();
    } else {
      throw new IllegalArgumentException("Unknown method " + call.method);
    }
  }
}
