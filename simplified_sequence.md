# Proposal

## New Table B Entries

__*Class 42: BUFR / CREX Oceanographic Elements*__

| Descriptor | Name | Units | Scale | Reference | Width | Notes | CREX scale | CREX width |
| :----------: | ---- | :-----: | :-----: |:---------:|:-----:| :-----: |:----------:|:----------:|
| 0-42-016 | Sea water potential density referenced to sea surface | kg m-3 | 5 | -10000000 |  24   |  |            |            |

## New Table D Entries

__*Category 15: Oceanographic report sequences*__

| Table Reference | Table References | Element Name                                                                 | Description                                                                      |
|:---------------:|:----------------:|------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
|    3-15-012     |                  | Ocean glider trajectory profile sequence                                     | Sequence for reporting observations from a single glider profile                     |
|                 |     3-01-150     | (WIGOS identifier)                                                           |                                                                                        |
|                 |     2-01-129     | Change data width                                                            | Increase width of following elements by 1 bit                                          |
|                 |     0-01-087     | WMO marine observing platform extended identifier                            |                                                                                        |
|                 |     2-01-000     | Change data width                                                            | Cancel increase in width                                                               |
|                 |     0-01-019     | Long station or site name                                                    |                                                                                        |
|                 |     0-01-036     | Agency in charge of operating the observing platform                         |                                                                                        |
|                 |     0-02-148     | Data collection and/or location system                                       |                                                                                        |
|                 |     0-01-085     | Observing platform manufacturer's model                                      |                                                                                        |
|                 |     0-01-086     | Observing platform manufacturer's serial number                              |                                                                                        |
|                 |     0-08-021     | Time significance                                                            | Set to 25, nominal reporting time                                                      |
|                 |     3-01-011     | (Year, month, day)                                                           |                                                                                        |
|                 |     3-01-013     | (Hour, minute, second)                                                       |                                                                                        |
|                 |     3-01-021     | (Latitude / longitude (high accuracy))                                       |                                                                                        |
|                 |     0-11-104     | True heading of aircraft, ship or other mobile platform                      |                                                                                        |
|                 |     0-02-169     | Anemometer type                                                              | Set to 2, wind observation through ambient noise (WOTAN)                               |
|                 |     0-11-002     | Wind speed                                                                   |                                                                                        |
|                 |     0-11-001     | Wind direction                                                               |                                                                                        |
|                 |     0-02-169     | Anemometer type                                                              | Set to missing / cancel previous value                                                 |
|                 |     0-22-032     | Speed of sea surface current                                                 |                                                                                        |
|                 |     0-22-005     | Direction of sea-surface current                                             |                                                                                        |
|                 |     3-01-011     | (Year, month, day)                                                           |                                                                                        |
|                 |     3-01-013     | (Hour, minute, second)                                                       |                                                                                        |
|                 |     0-08-021     | Time significance                                                            | Set to 2, time averaged                                                                |
|                 |     0-04-025     | Time period or displacement                                                  | Duration of dive                                                                       |
|                 |     3-01-021     | (Latitude / longitude (high accuracy))                                       |                                                                                        |
|                 |     0-22-031     | Speed of current                                                             |                                                                                        |
|                 |     0-22-004     | Direction of current                                                         |                                                                                        |
|                 |     0-08-021     | Time significance                                                            | Set to missing / cancel previous value                                                 |
|                 |     0-05-068     | Profile number                                                               |                                                                                        |
|                 |     0-01-079     | Unique identifier for profile                                                |                                                                                        |
|                 |     1-26-000     | Delayed replication of 26 descriptors                                        |                                                                                        |
|                 |     0-31-001     | Delayed descriptor replication factor                                        | Number of profile sections (e.g. descending, horizontal, ascending)                    |
|                 |     0-22-056     | Direction of profile                                                         | 0 (ascending / upwards profile), 1 (descending / downwards profile), or 2 (horizontal) |
|                 |     1-23-000     | Delayed replication of 23 descriptors                                        |                                                                                        |
|                 |     0-31-002     | Extended delayed descriptor replication factor                               |                                                                                        |
|                 |     3-01-011     | Year, month, day                                                             |                                                                                        |
|                 |     3-01-013     | Hour, minute, second                                                         |                                                                                        |
|                 |     3-01-021     | Latitude / Longitude (high accuracy)                                         |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 20, position                                                                           |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-07-062     | Depth below water surface                                                    |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 13, water depth at a level                                                             |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-22-065     | Water pressure                                                               |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 10, water pressure at a level                                                          |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-22-045     | Sea/water temperature                                                        |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 11, water temperature at a level                                                       |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-22-066     | Water conductivity                                                           |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 25, water conductivity at a level                                                      |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-22-064     | Salinity                                                                     |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 12, salinity at a level                                                                |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |
|                 |     0-42-016     | Sea water potential density referenced to sea surface                        |                                                                                        |
|                 |     0-08-080     | Qualifier for GTSPP quality flag                                             | 26, sea water potential density at a level                                             |
|                 |     0-33-050     | Global GTSPP quality flag                                                    |                                                                                        |

## Additions to code tables
<p align="center">0-08-080
<br>Qualifier for GTSPP quality flag</p>
<p align="center">
<table>
<tr><th>Code figure</th><th>Meaning</th></tr>
<tr><td align="center">0</td><td>Total water pressure profile</td></tr>
<tr><td align="center">1</td><td>Total water temperature profile</td></tr>
<tr><td align="center">2</td><td>Total water salinity profile</td></tr>
<tr><td align="center">3</td><td>Total water conductivity profile</td></tr>
<tr><td align="center">4</td><td>Total water depth</td></tr>
<tr><td align="center">5–9</td><td>Reserved</td></tr>
<tr><td align="center">10</td><td>Water pressure at a level</td></tr>
<tr><td align="center">11</td><td>Water temperature at a level</td></tr>
<tr><td align="center">12</td><td>Salinity at a level</td></tr>
<tr><td align="center">13</td><td>Water depth at a level</td></tr>
<tr><td align="center">14</td><td>Sea/water current speed at a level</td></tr>
<tr><td align="center">15</td><td>Sea/water current direction at a level</td></tr>
<tr><td align="center">16</td><td>Dissolved oxygen at a level</td></tr>
<tr><td align="center">17–19</td><td>Reserved</td></tr>
<tr><td align="center">20</td><td>Position</td></tr>
<tr><td align="center">* 25</td><td>Water conductivity at a level</td></tr>
<tr><td align="center">* 26</td><td>Sea water potential density referenced to sea surface at a level</td></tr>
<tr><td align="center">32-62</td><td>Reserved</td></tr>
<tr><td align="center">63</td><td>Missing value</td></tr>
</table>
<p>New entries (25 - 31) indicated by *.</p>
