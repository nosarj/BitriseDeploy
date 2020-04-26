//
//  MockArtifactResponse.swift
//  BitriseDeployTests
//
//  Created by Yishai Roodyn on 26/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

struct MockArtifactResponse {
    
    static let mockArtifactResponse: [String: Any] = [
        "data": [
            "title": "Test.comDebug.ipa",
            "artifact_type": "ios-ipa",
            "artifact_meta": [
                "info_type_id": "ios-ipa",
                "file_size_bytes": "161505950.000000",
                "test_device_id_list": [
                    "00008020-000560A201E8003A",
                    "2305e21cec8a158d66b01513945328d2da581412",
                    "3362f72a3d784657ce96682039971090ab83d099",
                    "fb2f2d5ded239c9454041661fa3c3c2818e0cf37",
                    "00008020-00191D691E88002E",
                    "00008020-000E25AA3AC2002E",
                    "00008006-00041D64110A002E",
                    "00008020-001611310282002E",
                    "7bce11bcf668e03c90819262e53ee5e2088a1c13",
                    "00008027-000808EE0A31002E",
                    "00008020-0004441A0E9A002E",
                    "9324412f46d9b78c50aa43955e0e0458928c04b3",
                    "00008020-001921AC0E92002E",
                    "7cb1660bf22a850e639ce8e2a6fb822f9af12b93",
                    "55bac2886816d6cb90f15f064382caeda17df72e",
                    "1b812e0f99ffe1d52a5077e5922f35e6b45488cf",
                    "7550eb6b24d5ac17e2d7f272724e29b1cf04cf32",
                    "0f5f8670d6bd177d43f864e6bf3dca430fa0a73b",
                    "2428df95a55b866f195e51cf5916e674a73525cd",
                    "00008020-001018E02E6A002E",
                    "1a6a4b6f9a129484e9b2bf8085aae4c87db652e2",
                    "8f123b06361ef79944f98c192935a69c1384c97e",
                    "00008020-000334E81E68002E",
                    "ccb20697bbd779acc2ee4b0fa607b65afd86b557",
                    "234630615b31b0d5fd73c98bc98259130a2b4db3",
                    "306f54d1f8841b6575a8c246953f78bbb3494d09",
                    "43a334cacf2bf25f3174090c89187b0449d62160",
                    "f5dd85acc55926b03755b8193fd7d09f575c7c74",
                    "00008030-000C19C61E84802E",
                    "677806868835fc3c2c045e66eff7d5c522a499e8",
                    "00008020-001E39D20EDA002E",
                    "00008020-000C5D882192002E",
                    "00008020-00167C460EBA002E",
                    "00008020-0002191E2E7B002E",
                    "518c4ac4c455b698b35d7e42ad572b3f1a92a39e",
                    "00008030-000C2CD83AD8802E"
                ],
                "is_test_install_enabled": true,
                "install_type": "limited",
                "app_info": [
                    "app_title": "Bitrise DEV",
                    "bundle_id": "com.Test.appDebug",
                    "version": "5.9.1",
                    "build_number": "915",
                    "min_OS_version": "11.0",
                    "device_family_list": [
                        1,
                        2
                    ]
                ],
                "provisioning_info": [
                    "creation_date": "2020-04-01T11:32:42Z",
                    "expire_date": "2021-04-01T11:32:42Z",
                    "team_name": "Fusion Media Limited",
                    "profile_name": "Bitrise Dev",
                    "provisions_all_devices": false,
                    "ipa_export_method": "development",
                    "distribution_type": "development"
                ]
            ],
            "expiring_download_url": "https://bitrise-prod-build-storage.s3.amazonaws.com/builds/6a207b1bc7a8501b/artifacts/37001183/Test.comDebug.ipa?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIV2YZWMVCNWNR2HA%2F20200426%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200426T052208Z&X-Amz-Expires=600&X-Amz-SignedHeaders=host&X-Amz-Signature=dfa8352695e24c07975cd869fbd1a5693f1a1ad2a22b2820d1a3f0f02783fda3",
            "is_public_page_enabled": true,
            "slug": "0a75ce3ba7d97a2d",
            "public_install_page_url": "https://www.bitrise.io/artifact/37001183/p/73eb184c21ab5f60aa470f0478fab357",
            "file_size_bytes": 161505950
        ]
    ]
    
    
}
