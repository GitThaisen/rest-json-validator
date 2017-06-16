# rest-json-validator
This is a module which intended use is to validate a json structure based on a given specification. It is currently used to verify assumptions from one of our json REST APIs. We're able to verify the structure of the API response as well as the returned values.

## Example of use

call `gem install rest-json-validator` and add

    require 'rest-json-validator'
    include RestJsonValidator

to the top of you code.


Given an API endpoint /mediaelement resonse expected to be

    MEDIAELEMENT_CHECKS = {
      "mediaUrl": "https://host/path/playlist.m3u8",
      "mediaAssets": [
      {
        "url": "https://host/path/playlist.m3u8",
        "duration": "PT0S",
        "carrierId": null,
        "webVttSubtitlesUrl": null,
        "timedTextSubtitlesUrl": null,
        "bufferDuration": "PT3H"
      }
    ],
    "bitrateInfo": {
      "startIndex": 3,
      "maxIndex": 4
    },
    "playerType": "HLS",
    }

you can specify it like this:

    MEDIAELEMENT_CHECKS = {
      "mediaUrl"        => {},
      "mediaAssets"        => [
        {
         "url"     => {},
         "duration"    => {},
         "carrierId"    => {},
         "webVttSubtitlesUrl"    => {},
         "bufferDuration"    => {}
        }
      ],
      "bitrateInfo"        => {
             "startIndex"         => {},
             "maxIndex"           => {},
         },
      "playerType"            => {}
      }

then test it by

1: creating an instance of RestJsonValidator:

    class Validator < JsonValidator

2: Adding yourself as a listener to it:

    Validator.add_listener yourTestDriver

3: calling validate with your actual data and specification as arguments:

    validator.validate_json_api_compliance(mediaelement, MEDIAELEMENT_CHECKS)


Your validator will recursively run through the specification, and return a test response to the listener. Observe the empty curly brackets, indicating we do not investigate the content of any returned values, only the api response structure.

## Example og a bit more enhanced check:

Change your specification (MEDIAELEMENT_CHECKS) by replacing

    "mediaUrl"        => {},

with

    "mediaUrl"        => {:check_media_url},

Also, implement a method in your Validator, called `check_media_url`.
This will trigger the method during verification, shipping in the value of the mediaUrl parameter, enabling you to validate the contents of the API response as well.
