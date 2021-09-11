#include <a_samp>

stock LoadVehicles() {
    CreateVehicle(412, 2021.4110, -1104.0613, 24.6057, 75.3583, 5, 5, -1); // Ballas Voodoo
    CreateVehicle(412, 2013.8748, -1102.2113, 24.7495, 76.7813, 5, 5, -1); // VooDoo 2 - Ballas
    CreateVehicle(468, 2019.1960, -1095.0884, 24.2783, 117.9535, 5, 5, -1); // Sanches 1 - Ballas
    CreateVehicle(468, 2021.3163, -1096.0846, 24.2759, 121.4706, 5, 5, -1); // Sanches 2 - Ballas
    CreateVehicle(492, 2030.0804, -1106.4938, 24.4581, 73.3377 ,5, 5, -1); // GreenWood 1 - Ballas
    CreateVehicle(492, 2009.9723, -1091.6123, 24.3997, 67.4654, 5, 5, -1); // GreenWood 2 - Ballas
    
    CreateVehicle(492, 2488.7278, -1683.8790, 13.2033, 272.2383, 86, 86, -1); // GreenWood 1 - GSF
    CreateVehicle(492, 2505.8430, -1679.2351, 13.2436, 316.5632, 86, 86, -1); // GreenWood 2 - GSF
    CreateVehicle(412, 2495.5291, -1683.6169, 13.2372, 279.9983, 86, 86, -1); // VooDoo 1 - GSF
    CreateVehicle(412, 2502.5881, -1685.0428, 13.3299, 32.1788, 86, 86, -1); // VooDoo 2 - GSF
    CreateVehicle(468, 2509.1111, -1668.5685,13.0498,64.7892,86,86, -1); // Sanches 1 - GSF
    CreateVehicle(468, 2508.6960, -1669.6703,13.0482,67.2267,86,86, -1); // Sanches 2 - GSF
    CreateVehicle(468, 2509.1106, -1668.5686,13.0414,64.7899,86,86, -1); // Sanches 3 - GSF
    
    CreateVehicle(482, -57.1328, -1554.5337,2.7349,140.9352,36,36, -1); // Burrito 1 - TLMC
    CreateVehicle(554, -60.1061, -1552.0509,2.7274,142.3554,36,36, -1); // Yosemite 1 - TLMC
    CreateVehicle(554, -83.5966, -1556.2191,2.6965,225.0783,36,36, -1); // Yosemite 2 - TLMC
    CreateVehicle(463, -71.0254, -1549.1920,2.1505,166.7700,36,36, -1); // FreeWay 1 - TLMC
    CreateVehicle(463, -73.1476, -1547.0780, 2.1385, 171.3662, 36, 36, -1); // FreeWay 2 - TLMC
    CreateVehicle(463, -75.5036, -1545.3677, 2.1481, 167.4622, 36, 36, -1); // FreeWay 3 - TLMC
    
    CreateVehicle(463, 650.3444, -508.5670, 15.8726, 37.2249, 0, 0, -1); // FreeWay 2 - OUTL
    CreateVehicle(463, 650.4865, -505.8452, 15.8697, 36.4654, 0, 0, -1); // FreeWay 2 - OTLC
    CreateVehicle(463, 650.6729, -503.5124, 15.8724, 41.6982, 0, 0, -1); // FreeWay 3 - OUTL
    CreateVehicle(482, 634.7406, -506.2940, 16.4637, 271.7018, 0, 0, -1); // Burrito 1 - OUTL
    CreateVehicle(554, 635.2747, -509.5439, 16.4213, 269.0793, 0, 0, -1); // YoseMite 1 - OUTL
    CreateVehicle(554, 639.1980, -499.8280, 16.4229, 269.2195, 0, 0, -1); // YoseMite 2 - OUTL
    return 1;
}