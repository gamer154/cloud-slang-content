#   (c) Copyright 2014-2017 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: Parses a JSON response holding Consul key information.
#!
#! @input json_response: Response holding Consul key information.
#!
#! @output decoded: Parsed response.
#! @output key: Key name.
#! @output flags: Key flags.
#! @output create_index: Key create index.
#! @output value: Key value.
#! @output modify_index: Key modify index.
#! @output lock_index: Key lock index.
#! @output return_result: Response of the operation.
#! @output error_message: Return_result if there was an error.
#! @output return_code: '0' if parsing was successful, '-1' otherwise.
#!
#! @result SUCCESS: Parsing was successful (return_code == '0').
#! @result FAILURE: Otherwise.
#!!#
########################################################################################################################

namespace: io.cloudslang.consul

operation:
  name: parse_key

  inputs:
    - json_response

  python_action:
    script: |
      try:
        import json
        import base64

        decoded = json.loads(json_response)
        decoded = decoded[0]
        key = decoded['Key']
        flags = decoded['Flags']
        create_index = decoded['CreateIndex']
        value = encoded = base64.b64decode(decoded['Value'])
        modify_index = decoded['ModifyIndex']
        lock_index = decoded['LockIndex']
        return_code = '0'
        return_result = 'Parsing successful.'
      except:
        return_code = '-1'
        return_result = 'Parsing error or key does not exist.'

  outputs:
    - decoded: ${ str(decoded) }
    - key: ${ str(key) }
    - flags: ${ str(flags) }
    - create_index: ${ str(create_index) }
    - value: ${ str(value) }
    - modify_index: ${ str(modify_index) }
    - lock_index: ${ str(lock_index) }
    - return_result: ${ str(return_result) }
    - error_message: ${ str(return_result) if return_code == '-1' else ''}
    - return_code: ${ str(return_code) }

  results:
    - SUCCESS: ${return_code == '0'}
    - FAILURE
