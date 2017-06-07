module MediaelementTestSpec
  MEDIAELEMENT_V9_CHECKS = {
      '_links' => {
          'self' => {
              'href' => {}
          },
          'parent' => {
              'href' => {}
          },
      },
      'id'                  => {},
      'title'               => {},
      'playability'         => {},
      "streamingMode"       => {},
      "duration"            => {},
      "description"         => {},
      "legalAge"            => {
          "legalReference" => {},
          "body" => {
              :optionals => {
                  "rating" => {}
              },
              "rating" => {
                  "code" => {},
                  "displayValue" => {},
                  "displayAge" => {}
              },
              "status" => {}
          }
      },
      "availability"        => {
          "information"     => {},
          "isGeoBlocked"    => {},
          "onDemand"        => {
              "from"         => :composite,
              "to"           => :composite,
              "hasRightsNow" => :composite
          },
          "live"            => {
              "type"        => :composite,
              "isOngoing"   => :composite,
              "transmissionInterval"     => {
                  "from"    => :composite,
                  "to"      => :composite
              }
          },
          "externalEmbeddingAllowed"     => {}
      },
      "statistics"=> {
          "scores"    => {
              "springStreamSite" => :composite,
              "springStreamStream" => :composite,
              "springStreamContentType" => :composite,
              "springStreamProgramId" => :composite
          },
          "akamai"=> {
              "config"  => {
                  "beacon" => {},
              },
              "data" => {
                  "show" => :composite,
                  "title" => :composite,
                  "category" => :composite,
                  "contentLength" => :composite,
                  "device" => :composite,
                  "playerId" => :composite,
                  "deliveryType" => :composite,
                  "playerInfo" => :composite,
                  "cdnName" => :composite
              }
          },
          "ga" => {
              "dimension1"    => :composite,  # kildesystem:id, e. g. prf:NNFA41000216
              "dimension2"    => :composite,  # tittel
              "dimension3"    => :composite,  # publiseringsår
              "dimension4"    => :composite,  #  -måned
              "dimension5"    => :composite,  #  -dag
              "dimension21"   => :composite,  # hvis åpnet fra annet nettsted: referrer uten innledende "www."
              "dimension23"   => :composite,
              "dimension22"   => :composite,  # fullstending document referrer uten schema (http[s]://) og innledende "www."
              "dimension25"   => :composite,  # hvis pålogget: brukerid
              "dimension26"   => :composite,  # hvis pålogget: brukerid (ulikhet fra dimension8??)
              "dimension10"   => :composite   # normalisert id til innholdet (ofte dss. dimension1)
          }
      },
      "preplay" => {
          "poster" => {
              "images" => [
                  {
                      "url" => :composite,
                      "pixelWidth" => :composite
                  },

              ]
          }
      },
      "playable"=> {
          "endSequenceStartTime"=> {},
          "sourceMedium"=> {},
          "parts"=> [
              :data            => {
                  "part"=> {},
                  "duration"=> {},
                  "assets" => [
                      :data    => {
                          "url"=> :composite,
                          "format"=> :composite,
                          "mimeType"=> :composite,
                          "encrypted"=> {}
                      }
                  ],
                  "liveBuffer" => {
                      "bufferStartTime"=> :composite,
                      "bufferDuration"=> :composite
                  },
                  "subtitles"=> [
                      :data => {
                          "type"=> :composite,
                          "language"=> :composite,
                          "label"=> :composite,
                          "webVtt"=> :composite,
                          #"timedText"=> :composite
                      }
                  ],
                  "indexPoints"=> [
                      :data => {
                          "title" => :composite,
                          "startPoint" => :composite,
                          #"partId" => :composite
                      }
                  ],
                  #"encrypted" => {}
              }
          ]
      },
      "nonPlayable"=> {
          "reason"=> :composite,
          "messageType"=> :composite,
          "endUserMessage"=> :composite,
          "helpUrl"=> :composite,
          "availableAbroadUrl" => :composite
      }
  }

end