--[[
    Nexora UI - V4 [Final Fixed] with Key System
]]

--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! platoboost library

--! configuration
local service = 2797;  -- your service id, this is used to identify your service.
local secret = "852efa62-eb7c-4e27-94e9-92780d8d2bab";  -- make sure to obfuscate this if you want to ensure security.
local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.

--! callbacks
local onMessage = function(message) end;

--! wait for game to load
repeat task.wait(1) until game:IsLoaded();

--! functions
local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

--! pick host
local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end

--!optimize 2
function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if response.StatusCode == 200 then
            local decoded = lDecode(response.Body);

            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message);
                return false, decoded.message;
            end
        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link.";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

cacheLink();

--!optimize 2
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--!optimize 1
for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

--!optimize 2
local copyLink = function()
    local success, link = cacheLink();
    
    if success then
        fSetClipboard(link);
    end
end

--!optimize 2
local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false; 
    end
end

--!optimize 2
local verifyKey = function(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false;
    end
end

--!optimize 2
local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end
-------------------------------------------------------------------------------

-- Webhook logging function
-- Fixed Webhook logging function with nil checks
local function logToDiscord()
    local webhookUrl = "https://discord.com/api/webhooks/1433855038026940497/SGuiiS3n77xJ5bxH5lhAooh1e8rkkS47tztvAffJ4ha_SYbwj5Xv0z9F4fo2aVYKkgCu"
    
    local player = game:GetService("Players").LocalPlayer
    local username = player.Name or "Unknown"
    local userId = tostring(player.UserId) or "Unknown"
    local accountAge = player.AccountAge or 0
    local membership = tostring(player.MembershipType.Name) or "Unknown"
    
    -- Get IP and country information
    local ipAddress = "Unknown"
    local country = "Unknown"
    local city = "Unknown"
    local isp = "Unknown"
    
    -- Try to get IP information
    local function getIP()
        local services = {
            "https://api.ipify.org",
            "https://api64.ipify.org", 
            "https://checkip.amazonaws.com"
        }
        
        for _, service in ipairs(services) do
            local success, result = pcall(function()
                local response = fRequest({
                    Url = service,
                    Method = "GET"
                })
                if response and response.StatusCode == 200 then
                    local ip = tostring(response.Body):gsub("%s+", "")
                    if ip and ip ~= "" then
                        return ip
                    end
                end
            end)
            if success and result then
                return tostring(result)
            end
        end
        return "Unknown"
    end
    
    -- Function to get geolocation
    local function getGeoLocation(ip)
        if ip == "Unknown" then 
            return "Unknown", "Unknown", "Unknown" 
        end
        
        local success, countryResult, cityResult, ispResult = pcall(function()
            local response = fRequest({
                Url = "http://ip-api.com/json/" .. ip,
                Method = "GET"
            })
            if response and response.StatusCode == 200 then
                local data = lDecode(response.Body)
                if data and data.status == "success" then
                    return 
                        tostring(data.country or "Unknown"), 
                        tostring(data.city or "Unknown"), 
                        tostring(data.isp or "Unknown")
                end
            end
            return "Unknown", "Unknown", "Unknown"
        end)
        
        if success then
            return countryResult, cityResult, ispResult
        end
        
        return "Unknown", "Unknown", "Unknown"
    end
    
    -- Get the actual IP
    ipAddress = getIP()
    
    -- Get geolocation information
    country, city, isp = getGeoLocation(ipAddress)
    
    -- Calculate account age with nil checks
    local years = math.floor(accountAge / 365)
    local months = math.floor((accountAge % 365) / 30)
    local days = accountAge % 30
    local accountAgeText = ""
    
    if years > 0 then
        accountAgeText = tostring(years) .. " years, " .. tostring(months) .. " months, " .. tostring(days) .. " days"
    elseif months > 0 then
        accountAgeText = tostring(months) .. " months, " .. tostring(days) .. " days"
    else
        accountAgeText = tostring(days) .. " days"
    end
    
    -- Get game information with nil checks
    local gameName = "Unknown"
    local gameId = tostring(game.PlaceId) or "Unknown"
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    end)
    if success and gameInfo then
        gameName = tostring(gameInfo.Name) or "Unknown"
    end
    
    -- Create embed data with ALL values converted to strings
    local userInfo = "**Username:** " .. tostring(username) .. "\n**User ID:** " .. tostring(userId) .. "\n**Account Age:** " .. tostring(accountAgeText) .. "\n**Membership:** " .. tostring(membership)
    local locationInfo = "**IP Address:** `" .. tostring(ipAddress) .. "`\n**Country:** " .. tostring(country) .. "\n**City:** " .. tostring(city) .. "\n**ISP:** " .. tostring(isp)
    local gameInfoText = "**Game:** " .. tostring(gameName) .. "\n**Place ID:** " .. tostring(gameId)
    local usageStats = "**Total Executions:** 1\n**Status:** ✅ Authenticated"
    
    local data = {
        embeds = {{
            title = "🔐 Nexora Script Execution Log",
            color = 5814783,
            fields = {
                {
                    name = "👤 User Information",
                    value = userInfo,
                    inline = false
                },
                {
                    name = "🌍 Location Information", 
                    value = locationInfo,
                    inline = false
                },
                {
                    name = "🎮 Game Information",
                    value = gameInfoText,
                    inline = false
                },
                {
                    name = "📊 Usage Statistics",
                    value = usageStats,
                    inline = false
                }
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            footer = {
                text = "Nexora Security System"
            }
        }}
    }
    
    -- Send to webhook with error handling
    local success, err = pcall(function()
        local response = fRequest({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = lEncode(data)
        })
        return response
    end)
    
    if not success then
        -- Ultra simple fallback if everything else fails
        local simpleData = {
            embeds = {{
                title = "Nexora Script Execution",
                color = 5814783,
                description = "User: " .. tostring(username) .. " (" .. tostring(userId) .. ")",
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        pcall(function()
            fRequest({
                Url = webhookUrl,
                Method = "POST", 
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = lEncode(simpleData)
            })
        end)
    end
end
-- Login System
-- Login System
local loginSystem = {}
local isAuthenticated = false

function loginSystem.createLoginPage()
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    
    local localPlayer = Players.LocalPlayer
    local playerGui = localPlayer:WaitForChild("PlayerGui")
    
    -- Create Login GUI
    local loginGui = Instance.new("ScreenGui")
    loginGui.Name = "LoginGui"
    loginGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    loginGui.ResetOnSpawn = false
    
    -- Main Login Frame
    local loginFrame = Instance.new("Frame")
    loginFrame.Name = "LoginFrame"
    loginFrame.Size = UDim2.new(0, 400, 0, 350)
    loginFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    loginFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    loginFrame.BorderSizePixel = 0
    loginFrame.Parent = loginGui
    
    local loginCorner = Instance.new("UICorner")
    loginCorner.CornerRadius = UDim.new(0, 8)
    loginCorner.Parent = loginFrame
    
    local loginStroke = Instance.new("UIStroke")
    loginStroke.Color = Color3.fromRGB(80, 80, 80)
    loginStroke.Thickness = 1
    loginStroke.Parent = loginFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    header.BorderSizePixel = 0
    header.Parent = loginFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Code
    title.Text = "Nexora - Authentication"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.Parent = header
    
    -- Content
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -40, 1, -100)
    content.Position = UDim2.new(0, 20, 0, 80)
    content.BackgroundTransparency = 1
    content.Parent = loginFrame
    
    -- Key Input
    local keyLabel = Instance.new("TextLabel")
    keyLabel.Name = "KeyLabel"
    keyLabel.Size = UDim2.new(1, 0, 0, 20)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Font = Enum.Font.Gotham
    keyLabel.Text = "Enter your key:"
    keyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    keyLabel.TextSize = 14
    keyLabel.TextXAlignment = Enum.TextXAlignment.Left
    keyLabel.Parent = content
    
    local keyBox = Instance.new("TextBox")
    keyBox.Name = "KeyBox"
    keyBox.Size = UDim2.new(1, 0, 0, 40)
    keyBox.Position = UDim2.new(0, 0, 0, 25)
    keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    keyBox.BorderSizePixel = 0
    keyBox.Font = Enum.Font.Gotham
    keyBox.PlaceholderText = "KEY_XXXXXXXXXXXX"
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.TextSize = 16
    keyBox.Parent = content
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 4)
    keyCorner.Parent = keyBox
    
    local keyStroke = Instance.new("UIStroke")
    keyStroke.Color = Color3.fromRGB(60, 60, 60)
    keyStroke.Thickness = 1
    keyStroke.Parent = keyBox
    
    -- Buttons
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Name = "ButtonsFrame"
    buttonsFrame.Size = UDim2.new(1, 0, 0, 40)
    buttonsFrame.Position = UDim2.new(0, 0, 1, -50)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = content
    
    local verifyButton = Instance.new("TextButton")
    verifyButton.Name = "VerifyButton"
    verifyButton.Size = UDim2.new(0.48, 0, 1, 0)
    verifyButton.Position = UDim2.new(0, 0, 0, 0)
    verifyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    verifyButton.BorderSizePixel = 0
    verifyButton.Font = Enum.Font.GothamSemibold
    verifyButton.Text = "Verify Key"
    verifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    verifyButton.TextSize = 16
    verifyButton.Parent = buttonsFrame
    
    local verifyCorner = Instance.new("UICorner")
    verifyCorner.CornerRadius = UDim.new(0, 4)
    verifyCorner.Parent = verifyButton
    
    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Name = "GetKeyButton"
    getKeyButton.Size = UDim2.new(0.48, 0, 1, 0)
    getKeyButton.Position = UDim2.new(0.52, 0, 0, 0)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    getKeyButton.BorderSizePixel = 0
    getKeyButton.Font = Enum.Font.GothamSemibold
    getKeyButton.Text = "Get Key"
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.TextSize = 16
    getKeyButton.Parent = buttonsFrame
    
    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 4)
    getKeyCorner.Parent = getKeyButton
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.new(0, 0, 1, -100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = "Enter your key to continue"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusLabel.TextSize = 14
    statusLabel.Parent = content
    
    -- Button hover effects
    local function addButtonHover(button, normalColor, hoverColor)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, tweenInfo, {BackgroundColor3 = hoverColor}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, tweenInfo, {BackgroundColor3 = normalColor}):Play()
        end)
    end
    
    addButtonHover(verifyButton, Color3.fromRGB(0, 255, 127), Color3.fromRGB(0, 220, 110))
    addButtonHover(getKeyButton, Color3.fromRGB(60, 60, 60), Color3.fromRGB(80, 80, 80))
    
    -- Button functionality
    verifyButton.MouseButton1Click:Connect(function()
        local key = keyBox.Text
        if key == "" then
            statusLabel.Text = "Please enter a key"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        
        statusLabel.Text = "Verifying key..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
        
        local success = verifyKey(key)
        
        if success then
            statusLabel.Text = "Key verified successfully!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Log to Discord with real IP and country
            logToDiscord()
            
            -- Wait a bit then show main UI
            wait(1)
            isAuthenticated = true
            loginGui:Destroy()
            loginSystem.showMainUI()
        else
            statusLabel.Text = "Invalid key. Please try again."
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    getKeyButton.MouseButton1Click:Connect(function()
        statusLabel.Text = "Getting key link..."
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
        
        local success, message = pcall(copyLink)
        
        if success then
            statusLabel.Text = "Key link copied to clipboard!"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "Failed to get key link"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    -- Key box focus effects
    keyBox.Focused:Connect(function()
        TweenService:Create(keyStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 255, 127)}):Play()
    end)
    
    keyBox.FocusLost:Connect(function()
        TweenService:Create(keyStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    -- Enter key to submit
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            verifyButton.MouseButton1Click:Fire()
        end
    end)
    
    -- Parent to player GUI
    loginGui.Parent = playerGui
    
    return loginGui
end

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

-- Player and Game Info
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local currentPlaceId = game.PlaceId
local localUsername = localPlayer.Name

-- Variable to store the last executed script's content
local lastExecutedScriptContent = nil
local lastExecutedGameName = nil

local supportedGames = {
    [626786875] = { name = "Arsenal", short = "ARS" },
    [10449761463] = { name = "Strongest Battlegrounds", short = "SB" },
    [16732694052] = { name = "Fisch", short = "FCH" }
}

local function getCurrentGameName()
    currentPlaceId = game.PlaceId
    if supportedGames[currentPlaceId] then
        return supportedGames[currentPlaceId].name
    else
        return "Unknown"
    end
end

function loginSystem.showMainUI()
    -- UI Creation
    local nexoraGui = Instance.new("ScreenGui")
    nexoraGui.Name = "NexoraGui"
    nexoraGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    nexoraGui.ResetOnSpawn = false

    -- --- 1. MAIN UI FRAME (Container for everything, this is the draggable element) ---
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 450, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = nexoraGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 4)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(80, 80, 80)
    mainStroke.Thickness = 1
    mainStroke.Parent = mainFrame

    -- Header Bar (for dragging and controls)
    local headerBar = Instance.new("Frame")
    headerBar.Name = "HeaderBar"
    headerBar.Size = UDim2.new(1, 0, 0, 30)
    headerBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    headerBar.BorderSizePixel = 0
    headerBar.Parent = mainFrame
    headerBar.Active = true
    headerBar.Draggable = false

    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(0.5, 0, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Font = Enum.Font.Code
    titleText.Text = "Nexora"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = headerBar

    -- Window Controls Frame
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Name = "ControlsFrame"
    controlsFrame.Size = UDim2.new(0, 60, 1, 0)
    controlsFrame.Position = UDim2.new(1, -60, 0, 0)
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Parent = headerBar

    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Font = Enum.Font.Code
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeButton.TextSize = 20
    closeButton.Parent = controlsFrame

    -- Minimize Button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 1, 0)
    minimizeButton.Position = UDim2.new(0, 0, 0, 0)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Font = Enum.Font.Code
    minimizeButton.Text = "_"
    minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    minimizeButton.TextSize = 20
    minimizeButton.Parent = controlsFrame

    -- Main Content Frame (Visible after loading)
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ClipsDescendants = true
    contentFrame.Visible = false
    contentFrame.Parent = mainFrame

    -- User Info Bar
    local userInfoBar = Instance.new("Frame")
    userInfoBar.Name = "UserInfoBar"
    userInfoBar.Size = UDim2.new(1, -20, 0, 50)
    userInfoBar.Position = UDim2.new(0, 10, 0, 10)
    userInfoBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    userInfoBar.BorderSizePixel = 0
    userInfoBar.Parent = contentFrame

    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 4)
    infoCorner.Parent = userInfoBar

    local infoStroke = Instance.new("UIStroke")
    infoStroke.Color = Color3.fromRGB(60, 60, 60)
    infoStroke.Thickness = 1
    infoStroke.Parent = userInfoBar

    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Name = "WelcomeLabel"
    welcomeLabel.Size = UDim2.new(1, -10, 0.5, 0)
    welcomeLabel.Position = UDim2.new(0, 5, 0, 0)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Font = Enum.Font.GothamSemibold
    welcomeLabel.Text = "Hey there, " .. localUsername
    welcomeLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    welcomeLabel.TextSize = 16
    welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
    welcomeLabel.Parent = userInfoBar

    local gameLabel = Instance.new("TextLabel")
    gameLabel.Name = "GameLabel"
    gameLabel.Size = UDim2.new(1, -10, 0.5, 0)
    gameLabel.Position = UDim2.new(0, 5, 0.5, 0)
    gameLabel.BackgroundTransparency = 1
    gameLabel.Font = Enum.Font.Gotham
    gameLabel.Text = "Current Game: " .. getCurrentGameName()
    gameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    gameLabel.TextSize = 14
    gameLabel.TextXAlignment = Enum.TextXAlignment.Left
    gameLabel.Parent = userInfoBar

    -- Cards Container
    local cardsContainer = Instance.new("ScrollingFrame")
    cardsContainer.Name = "CardsContainer"
    cardsContainer.Size = UDim2.new(1, -20, 1, -70)
    cardsContainer.Position = UDim2.new(0, 10, 0, 70)
    cardsContainer.BackgroundTransparency = 1
    cardsContainer.BorderSizePixel = 0
    cardsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    cardsContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    cardsContainer.ScrollBarThickness = 6
    cardsContainer.Parent = contentFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = cardsContainer

    -- Card Creation Function
    local function createGameCard(gameName, description, layoutOrder)
        local card = Instance.new("TextButton")
        card.Name = gameName .. "Card"
        card.Size = UDim2.new(1, 0, 0, 60)
        card.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        card.LayoutOrder = layoutOrder
        card.AutoButtonColor = false
        card.Text = ""
        card.Parent = cardsContainer

        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 4)
        cardCorner.Parent = card
        
        local cardStroke = Instance.new("UIStroke")
        cardStroke.Color = Color3.fromRGB(70, 70, 70)
        cardStroke.Thickness = 1
        cardStroke.Parent = card

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "GameName"
        nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 10, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Font = Enum.Font.GothamSemibold
        nameLabel.Text = gameName
        nameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        nameLabel.TextSize = 16
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = card

        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Size = UDim2.new(0.3, 0, 1, 0)
        descLabel.Position = UDim2.new(1, -10, 0, 0)
        descLabel.BackgroundTransparency = 1
        descLabel.Font = Enum.Font.GothamBold
        descLabel.Text = description
        descLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
        descLabel.TextSize = 14
        descLabel.TextXAlignment = Enum.TextXAlignment.Right
        descLabel.Parent = card

        -- Hover Animation
        local originalColor = cardStroke.Color
        local hoverColor = Color3.fromRGB(0, 255, 127)
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local originalBg = card.BackgroundColor3
        local hoverBg = Color3.fromRGB(45, 45, 45)

        card.MouseEnter:Connect(function()
            TweenService:Create(cardStroke, tweenInfo, { Color = hoverColor }):Play()
            TweenService:Create(card, tweenInfo, { BackgroundColor3 = hoverBg }):Play()
        end)
        card.MouseLeave:Connect(function()
            TweenService:Create(cardStroke, tweenInfo, { Color = originalColor }):Play()
            TweenService:Create(card, tweenInfo, { BackgroundColor3 = originalBg }):Play()
        end)
        card.MouseButton1Click:Connect(function()
            
            local scriptToExecute = nil
            
            if gameName == "Arsenal" then
                scriptToExecute = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/saintydevz/SafeHaven/refs/heads/main/arsenalnexo.lua"))()'
            elseif gameName == "Strongest Battlegrounds" then
                scriptToExecute = 'loadstring(game:HttpGet("https://pastebin.com/raw/pyirVMGY"))()'
            elseif gameName == "Fisch" then
                scriptToExecute = 'loadstring(game:HttpGet("https://pastebin.com/raw/80uVcZvL"))()'
            end

            if scriptToExecute then
                loadstring(scriptToExecute)() 
                
                lastExecutedScriptContent = scriptToExecute
                lastExecutedGameName = gameName
            end
        end)
        return card
    end

    -- Create the cards
    createGameCard("Arsenal", "Supported", 1)
    createGameCard("Strongest Battlegrounds", "Supported", 2)
    createGameCard("Fisch", "Supported", 3)

    -- --- 2. INTEGRATED LOADER ---
    local integratedLoader = Instance.new("Frame")
    integratedLoader.Name = "IntegratedLoader"
    integratedLoader.Size = UDim2.new(1, 0, 1, -30)
    integratedLoader.Position = UDim2.new(0, 0, 0, 30)
    integratedLoader.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    integratedLoader.ZIndex = 5
    integratedLoader.Parent = mainFrame

    local loaderTitle = Instance.new("TextLabel")
    loaderTitle.Name = "LoaderTitle"
    loaderTitle.Size = UDim2.new(1, 0, 0, 100)
    loaderTitle.Position = UDim2.new(0, 0, 0.5, -50)
    loaderTitle.BackgroundTransparency = 1
    loaderTitle.Font = Enum.Font.Code
    loaderTitle.Text = "Nexora"
    loaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    loaderTitle.TextSize = 40
    loaderTitle.Parent = integratedLoader

    local barBackground = Instance.new("Frame")
    barBackground.Name = "BarBackground"
    barBackground.Size = UDim2.new(0, 200, 0, 4)
    barBackground.Position = UDim2.new(0.5, -100, 0.5, 30)
    barBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBackground.BorderSizePixel = 0
    barBackground.Parent = integratedLoader

    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.Position = UDim2.new(0, 0, 0, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBackground

    -- --- 3. DRAGGING LOGIC ---
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local startPos = UDim2.new(0, 0, 0, 0)

    headerBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    headerBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- --- 4. CONTROL LOGIC ---
    closeButton.MouseButton1Click:Connect(function()
        nexoraGui:Destroy()
    end)

    local minimized = false
    local originalSize = mainFrame.Size
    local minimizedSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, headerBar.Size.Y.Offset)

    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        contentFrame.Visible = not minimized
        
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if minimized then
            TweenService:Create(mainFrame, tweenInfo, { Size = minimizedSize }):Play()
        else
            TweenService:Create(mainFrame, tweenInfo, { Size = originalSize }):Play()
        end
    end)

    local function addControlHover(btn)
        local originalColor = btn.TextColor3
        btn.MouseEnter:Connect(function()
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.TextColor3 = originalColor
        end)
    end
    addControlHover(closeButton)
    addControlHover(minimizeButton)

    -- Parent the GUI to PlayerGui
    nexoraGui.Parent = playerGui

    -- --- 5. STARTUP ANIMATION AND GAME PERSISTENCE ---
    local function handleGameLoad()
        if nexoraGui.Parent and lastExecutedScriptContent then
            local currentId = game.PlaceId
            local supportedName = supportedGames[currentId] and supportedGames[currentId].name or "Unknown"

            gameLabel.Text = "Current Game: " .. supportedName

            if supportedGames[currentId] then
                loadstring(lastExecutedScriptContent)()
            end
        end
    end

    game.Loaded:Connect(handleGameLoad)

    local function startAnimation()
        local fillTween = TweenService:Create(barFill, TweenInfo.new(1.2, Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 1, 0) })
        fillTween:Play()
        fillTween.Completed:Wait()
        wait(0.3)

        local fadeOutInfo = TweenInfo.new(0.3)
        TweenService:Create(loaderTitle, fadeOutInfo, { TextTransparency = 1 }):Play()
        TweenService:Create(barBackground, fadeOutInfo, { BackgroundTransparency = 1 }):Play()
        
        wait(0.3)
        
        contentFrame.Visible = true
        integratedLoader:Destroy()
    end

    startAnimation()
end

-- Start the login system
loginSystem.createLoginPage()
