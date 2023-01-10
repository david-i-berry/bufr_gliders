# load modules
import json
from eccodes import (codes_bufr_new_from_samples, codes_set, codes_set_array, codes_write,
                     codes_get_native_type, codes_release)
from eccodes import (CODES_MISSING_LONG, CODES_MISSING_DOUBLE)

missing_values = {
    'int': CODES_MISSING_LONG,
    'float': CODES_MISSING_DOUBLE
}

# load json data
with open("/local/test-data/output/melonhead.json") as fh:
    data_to_encode = json.load(fh)

headers = data_to_encode["headers"]
delayed_replications = headers["inputDelayedDescriptorReplicationFactor"]
extended_delayed_replications = headers["inputExtendedDelayedDescriptorReplicationFactor"]
# create new BUFR handle
bufr_msg = codes_bufr_new_from_samples("BUFR4")

# set delayed descriptors
if isinstance(delayed_replications, list):
    codes_set_array(bufr_msg, "inputDelayedDescriptorReplicationFactor", delayed_replications)
else:
    codes_set(bufr_msg, "inputDelayedDescriptorReplicationFactor", delayed_replications)

if isinstance(extended_delayed_replications, list):
    codes_set_array(bufr_msg, "inputExtendedDelayedDescriptorReplicationFactor", extended_delayed_replications)
else:
    codes_set(bufr_msg, "inputExtendedDelayedDescriptorReplicationFactor", extended_delayed_replications)

for key, value in headers.items():
    if key not in ["inputDelayedDescriptorReplicationFactor", "inputExtendedDelayedDescriptorReplicationFactor"] :
        if isinstance(value, list):
            if None in value:
                expected_type = codes_get_native_type(bufr_msg, key)
                missing = missing_values[expected_type.__name__]
                value = [missing if v is None else v for v in value]
            codes_set_array(bufr_msg, key, value)
        else:
            if value is not None:
                codes_set(bufr_msg, key, value)


# data set values
for key, value in data_to_encode["data"].items():
    if isinstance(value, list):
        if len(value) == 1:
            value = value[0]
    if isinstance(value, list):
        # check for None
        if None in value:
            expected_type = codes_get_native_type(bufr_msg, key)
            missing = missing_values[expected_type.__name__]
            value = [missing if v is None else v for v in value]
        codes_set_array(bufr_msg, key, value)
    else:
        if value is not None:
            codes_set(bufr_msg, key, value)
# pack
codes_set(bufr_msg, "pack", True)

# write
with open("./test-data/output/glider-test.bufr", "wb") as fh:
    codes_write(bufr_msg, fh)

# release
codes_release(bufr_msg)