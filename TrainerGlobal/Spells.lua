local Spells = {}
Spells[1] = {47436, 47450, 11578, 47465, 47502, 34428, 1715, 2687, 71, 7386, 355, 72, 47437, 57823, 694, 2565, 676,
             47520, 20230, 12678, 47471, 1161, 871, 2458, 20252, 47475, 18499, 1680, 6552, 47488, 1719, 23920, 47440,
             3411, 64382, 55694, 57755, 42459, 750, 5246, 3127, 750}
Spells[2] = {3127, 19746, 19752, 750, 48942, 48782, 48932, 20271, 498, 10308, 1152, 10278, 48788, 53408, 48950, 48936,
             31789, 62124, 54043, 25780, 1044, 20217, 48819, 48801, 48785, 5502, 20164, 10326, 1038, 53407, 48943,
             20165, 48945, 642, 48947, 20166, 4987, 48806, 6940, 48817, 48934, 48938, 25898, 32223, 31884, 54428, 61411,
             53601, 750}
Spells[3] = {3043, 3127, 3045, 3034, 8737, 1494, 13163, 48996, 49001, 49045, 53338, 5116, 27044, 883, 2641, 6991, 982,
             1515, 19883, 20736, 48990, 2974, 6197, 1002, 14327, 5118, 49056, 53339, 49048, 19884, 34074, 781, 14311,
             1462, 19885, 19880, 13809, 13161, 5384, 1543, 19878, 49067, 3034, 13159, 19882, 58434, 49071, 49052, 19879,
             19263, 19801, 34026, 34600, 34477, 61006, 61847, 53271, 60192, 62757, 8737, 42459}
Spells[4] = {3127, 42459, 48668, 48638, 1784, 48657, 921, 1776, 26669, 51724, 6774, 11305, 1766, 48676, 48659, 1804,
             8647, 48691, 51722, 48672, 1725, 26889, 2836, 1833, 1842, 8643, 2094, 1860, 57993, 48674, 31224, 5938,
             57934, 51723}
Spells[5] = {528, 2053, 48161, 48123, 48125, 48066, 586, 48068, 48127, 48171, 48168, 10890, 6064, 988, 48300, 6346,
             48071, 48135, 48078, 453, 10955, 10909, 8129, 48073, 605, 48072, 48169, 552, 1706, 48063, 48162, 48170,
             48074, 48158, 48120, 34433, 48113, 32375, 64843, 64901, 53023}
Spells[6] = {3127, 50842, 49941, 49930, 47476, 45529, 3714, 56222, 48743, 48263, 49909, 47528, 45524, 48792, 57623,
             56815, 47568, 49895, 50977, 49576, 49921, 46584, 49938, 48707, 48265, 61999, 42650, 53428, 53331, 54447,
             53342, 54446, 53323, 53344, 70164, 62158, 48778, 51425, 49924, 750}
Spells[7] = {2062, 8737, 49273, 49238, 10399, 49231, 58753, 2484, 49281, 58582, 49233, 58790, 58704, 58643, 49277,
             61657, 8012, 526, 2645, 57994, 8143, 49236, 58796, 58757, 49276, 57960, 131, 58745, 6196, 58734, 58774,
             58739, 58656, 546, 556, 66842, 51994, 8177, 58749, 20608, 36936, 36936, 58804, 49271, 8512, 6495, 8170,
             66843, 55459, 66844, 3738, 2894, 60043, 51514}
Spells[8] = {42921, 42842, 42995, 42833, 27090, 33717, 42873, 42846, 12826, 28271, 61780, 61721, 28272, 42917, 43015,
             130, 42926, 43017, 475, 1953, 42940, 12051, 43010, 43020, 43012, 42859, 2139, 42931, 42985, 43008, 45438,
             43024, 43002, 43046, 42897, 42914, 66, 58659, 30449, 42956, 47610, 61316, 61024, 55342, 53142, 7301}
Spells[9] = {696, 47811, 47809, 688, 47813, 50511, 57946, 47864, 6215, 47878, 47855, 697, 47856, 47857, 5697, 47884,
             47815, 47889, 47820, 698, 712, 126, 5138, 5500, 11719, 132, 60220, 18647, 61191, 47823, 691, 47865, 47891,
             47888, 17928, 47860, 47825, 1122, 47867, 18540, 47893, 47838, 29858, 58887, 47836, 61290, 48018, 48020,
             23161}
Spells[11] = {3127, 42459, 48668, 48638, 1784, 48657, 921, 1776, 26669, 51724, 6774, 11305, 1766, 48676, 48659, 1804,
              8647, 48691, 51722, 48672, 1725, 26889, 2836, 1833, 1842, 8643, 2094, 1860, 57993, 48674, 31224, 5938,
              57934, 51723}

function Player:LearnAllSpells()
    local class = self:GetClass()
    for i = 1, #Spells[class], 1 do
        self:LearnSpell(Spells[class][i])
    end
    -- Restriction
    if class == 1 then
        if self:HasSpell(12294) then
            self:LearnSpell(47486)
        end
        if self:HasSpell(20243) then
            self:LearnSpell(47498)
        end
    elseif class == 2 then
        if self:HasSpell(20925) then
            self:LearnSpell(48952)
        end
        if self:HasSpell(12294) then
            self:LearnSpell(48827)
        end
        if self:HasSpell(20911) then
            self:LearnSpell(25899)
        end
        if self:HasSpell(20473) then
            self:LearnSpell(48825)
        end
        if self:IsAlliance() then
            self:LearnSpell(31801)
            self:LearnSpell(13819)
            self:LearnSpell(23214)
        else
            self:LearnSpell(53736)
            self:LearnSpell(34769)
            self:LearnSpell(34767)
        end
    elseif class == 3 then
        if self:HasSpell(19386) then
            self:LearnSpell(49012)
        end
        if self:HasSpell(53301) then
            self:LearnSpell(60053)
        end
        if self:HasSpell(19306) then
            self:LearnSpell(48999)
        end
        if self:HasSpell(19434) then
            self:LearnSpell(49050)
        end
    elseif class == 4 then
        if self:HasSpell(16511) then
            self:LearnSpell(48660)
        end
        if self:HasSpell(1329) then
            self:LearnSpell(48666)
        end
    elseif class == 5 then
        if self:HasSpell(34914) then
            self:LearnSpell(48160)
        end
        if self:HasSpell(47540) then
            self:LearnSpell(53007)
        end
        if self:HasSpell(724) then
            self:LearnSpell(48087)
        end
        if self:HasSpell(19236) then
            self:LearnSpell(48173)
        end
        if self:HasSpell(34861) then
            self:LearnSpell(48089)
        end
        if self:HasSpell(15407) then
            self:LearnSpell(48156)
        end
    elseif class == 6 then
        if self:HasSpell(55050) then
            self:LearnSpell(55262)
        end
        if self:HasSpell(49143) then
            self:LearnSpell(55268)
        end
        if self:HasSpell(49184) then
            self:LearnSpell(51411)
        end
        if self:HasSpell(55090) then
            self:LearnSpell(55271)
        end
        if self:HasSpell(49158) then
            self:LearnSpell(51328)
        end
    elseif class == 7 then
        if self:IsAlliance() then
            self:LearnSpell(32182)
        else
            self:LearnSpell(2825)
        end
        if self:HasSpell(61295) then
            self:LearnSpell(61301)
        end
        if self:HasSpell(974) then
            self:LearnSpell(49284)
        end
        if self:HasSpell(30706) then
            self:LearnSpell(57722)
        end
        if self:HasSpell(51490) then
            self:LearnSpell(59159)
        end
    elseif class == 8 then
        if self:IsAlliance() then
            self:LearnSpell(32271)
            self:LearnSpell(49359)
            self:LearnSpell(3565)
            self:LearnSpell(33690)
            self:LearnSpell(3562)
            self:LearnSpell(3561)
            self:LearnSpell(11419)
            self:LearnSpell(32266)
            self:LearnSpell(11416)
            self:LearnSpell(33691)
            self:LearnSpell(49360)
        else
            self:LearnSpell(3567)
            self:LearnSpell(35715)
            self:LearnSpell(3566)
            self:LearnSpell(49358)
            self:LearnSpell(32272)
            self:LearnSpell(3563)
            self:LearnSpell(11417)
            self:LearnSpell(35717)
            self:LearnSpell(32267)
            self:LearnSpell(49361)
            self:LearnSpell(11420)
            self:LearnSpell(11418)
        end
        if self:HasSpell(11366) then
            self:LearnSpell(42891)
        end
        if self:HasSpell(11426) then
            self:LearnSpell(43039)
        end
        if self:HasSpell(44457) then
            self:LearnSpell(55360)
        end
        if self:HasSpell(31661) then
            self:LearnSpell(42950)
        end
        if self:HasSpell(11113) then
            self:LearnSpell(42945)
        end
        if self:HasSpell(44425) then
            self:LearnSpell(44781)
        end
    elseif class == 9 then
        if self:HasSpell(17877) then
            self:LearnSpell(47827)
        end
        if self:HasSpell(30283) then
            self:LearnSpell(47847)
        end
        if self:HasSpell(30108) then
            self:LearnSpell(47843)
        end
        if self:HasSpell(50796) then
            self:LearnSpell(59172)
        end
        if self:HasSpell(48181) then
            self:LearnSpell(59164)
        end
        if self:HasSpell(18220) then
            self:LearnSpell(59092)
        end
    elseif class == 11 then
        if self:HasSpell(50516) then
            self:LearnSpell(61384)
        end
        if self:HasSpell(48505) then
            self:LearnSpell(53201)
        end
        if self:HasSpell(48438) then
            self:LearnSpell(53251)
        end
        if self:HasSpell(5570) then
            self:LearnSpell(48468)
        end
    end
end
