import { NativeModules } from 'react-native';
import {EndpointRequestBuilderPlaces} from './request_builders'

const bridge = NativeModules.RNNavitiaSDK

export default {
    init: (token) => bridge.init(token),
    endpoints: {
        places: { newRequestBuilder: () => new EndpointRequestBuilderPlaces() }
    },
    features: {
        autoComplete: { newRequestBuilder: () => new EndpointRequestBuilderPlaces() }
    }
};
