package com.baidu.openrasp.v8;

import org.scijava.nativelib.NativeLoader;

public class V8 {

    public static Logger logger = null;

    public synchronized static native boolean Initialize();

    public synchronized static native boolean Dispose();

    public synchronized static native boolean CreateSnapshot(String config, Object[] plugins);

    public static native String Check(String type, byte[] params, int params_size, Context context,
            boolean new_request);

    public static native String ExecuteScript(String source, String filename) throws Exception;

    static {
        // try {
        //     NativeLoader.loadLibrary("openrasp_v8_java");
        // } catch (Exception e) {
            // System.out.println(e);
            System.load("/Users/lanyuhang/Workspace/openrasp-v8/java/build/libopenrasp_v8_java.dylib");
        // }
    }

    public static void PluginLog(String msg) {
        if (logger != null) {
            logger.log(msg.replaceAll("\n$", ""));
        }
    }

    public static void SetPluginLogger(Logger logger) {
        V8.logger = logger;
    }

    public static void main(String[] args) {

    }
}
