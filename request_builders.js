import { NativeModules } from 'react-native';

const bridge = NativeModules.RNNavitiaSDK
console.log(NativeModules);

class BaseNavitiaRequestBuilder {
    constructor() {
        this.props = {};
    }
}

export class EndpointRequestBuilderPlaces extends BaseNavitiaRequestBuilder {
    withQ(q) {
        this.props.q = q;
        return this;
    }

    withCount(count) {
        this.props.count = count;
        return this;
    }

    get() {
        return bridge.endpoint_places(this.props);
    }
}
