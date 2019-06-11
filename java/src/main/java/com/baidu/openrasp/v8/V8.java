package com.baidu.openrasp.v8;

import org.scijava.nativelib.NativeLoader;

public class V8 {

    public static Logger logger = null;

    public synchronized static native boolean Initialize();

    public synchronized static native boolean Dispose();

    public synchronized static native boolean CreateSnapshot(String config, Object[] plugins);

    public static native String Check(String type, byte[] params, int params_size, Context context, boolean new_request,
            int timeout);

    public static native String ExecuteScript(String source, String filename) throws Exception;

    public static void Load() throws Exception {
        if (System.getProperty("java.vm.name").contains("JRockit")) {
            throw new Exception(
                    "OpenRASP has temporarily removed support of Oracle JRockit JDK, please refer to the following document for details: https://rasp.baidu.com/doc/install/manual/weblogic.html#faq-jrockit");
        }
        NativeLoader.loadLibrary("openrasp_v8_java");
    }

    public static void PluginLog(String msg) {
        if (logger != null) {
            logger.log(msg.replaceAll("\n$", ""));
        }
    }

    public static void SetPluginLogger(Logger logger) {
        V8.logger = logger;
    }
}
