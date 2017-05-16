package org.kisio.RNNavitiaSDK;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableNativeMap;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.bridge.UnexpectedNativeTypeException;

import org.json.JSONException;
import org.kisio.NavitiaSDK.BaseNavitiaRequestBuilder;
import org.kisio.NavitiaSDK.NavitiaConfiguration;
import org.kisio.NavitiaSDK.NavitiaSDK;
import org.kisio.NavitiaSDK.Places.EndpointPlaces;
import org.kisio.NavitiaSDK.Places.EndpointRequestBuilderPlaces;
import org.kisio.NavitiaSDK.ResourceRequestError;
import org.kisio.RNNavitiaSDK.util.MapUtil;

import java.util.HashMap;
import java.util.Map;

public class RNNavitiaSDK extends ReactContextBaseJavaModule {

    private NavitiaSDK sdk;

    public RNNavitiaSDK(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "RNNavitiaSDK";
    }

    @ReactMethod
    public void init(String token) {
        NavitiaConfiguration conf = new NavitiaConfiguration(token);
        this.sdk = new NavitiaSDK(conf);
        System.out.println("SDK created with token " + token);
    }

    @ReactMethod
    public void endpoint_places(ReadableMap params, final Promise promise) {
        EndpointPlaces places = this.sdk.getEndpoints().getPlaces();
        final EndpointRequestBuilderPlaces queryBuilder = places.newRequestBuilder();

        ReadableNativeMap paramsNativeMap = (ReadableNativeMap) params;
        HashMap<String, Object> paramsMap = paramsNativeMap.toHashMap();
        for (String key: paramsMap.keySet()) {
            String value = String.valueOf(this.extractMapValue(params, paramsMap, key));
            queryBuilder.addQueryParameter(key, value);
        }

        try {
            queryBuilder.rawGet(new BaseNavitiaRequestBuilder.BaseRequestCallback() {
                @Override
                public void callback(org.json.simple.JSONObject jsonObject) {
                    System.out.println(String.format("SDK places with query %s", queryBuilder.getUrl()));
                    try {
                        Map<String, Object> map = MapUtil.toMap(jsonObject);
                        promise.resolve(MapUtil.toWritableMap(map));
                    } catch (JSONException e) {
                        promise.reject(
                            String.valueOf(e.hashCode()),
                            e.getMessage(),
                            e.fillInStackTrace()
                        );
                    }
                }
            }, new BaseNavitiaRequestBuilder.ErrorRequestCallback() {
                @Override
                public void callback(ResourceRequestError resourceRequestError) {
                    System.out.println("SDK places fail");
                    promise.reject(
                            String.valueOf(resourceRequestError.getHttpStatusCode()),
                            resourceRequestError.getMessage(),
                            resourceRequestError.getInnerException().fillInStackTrace()
                    );
                }
            });
        } catch (Exception e) {
            promise.reject(
                String.valueOf(e.hashCode()),
                e.getMessage(),
                e.fillInStackTrace()
            );
        }
    }

    private Object extractMapValue(ReadableMap params, HashMap<String, Object> paramsMap, String key) {
        Object mapValue;
        if (ReadableType.Number == params.getType(key)) {
            try {
                mapValue = params.getInt(key);
            } catch (UnexpectedNativeTypeException e) {
                mapValue = params.getDouble(key);
            }
        } else {
            mapValue = paramsMap.get(key);
        }

        return mapValue;
    }
}
