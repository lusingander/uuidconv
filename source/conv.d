module conv;

import std.array : empty, replace;
import std.exception : collectException;
import std.uni : toUpper;
import std.uuid : parseUUID;

/// convert uuid
string convUUID(string id, bool dash, bool upper)
{
    string parsed;
    if (collectException(parseUUID(id).toString(), parsed)) {
        return "";
    }
    if (!dash) {
        parsed = parsed.replace("-", "");
    }
    if (upper) {
        parsed = parsed.toUpper();
    }
    return parsed;
}

unittest
{
    const src = [
        "8AB3060E-2CBA-4F23-C74C-B52Db3BDFB46",
        "8ab3060e-2cba-4f23-c74c-b52db3bdfb46",
        "8AB3060E2CBA4F23C74CB52DB3BDFB46",
        "8ab3060e2cba4f23c74cb52db3bdfb46"
    ];
    foreach (id; src) {
        assert(
            convUUID(id, false, false) == "8ab3060e2cba4f23c74cb52db3bdfb46",
            "dash=false, upper=false"
        );
        assert(
            convUUID(id, true, false) == "8ab3060e-2cba-4f23-c74c-b52db3bdfb46",
            "dash=true, upper=false"
        );
        assert(
            convUUID(id, false, true) == "8AB3060E2CBA4F23C74CB52DB3BDFB46",
            "dash=false, upper=true"
        );
        assert(
            convUUID(id, true, true) == "8AB3060E-2CBA-4F23-C74C-B52DB3BDFB46",
            "dash=true, upper=true"
        );
    }

    const invalid = [
        "8AB3060E-2CBA-4F23-C74C-B52DB3BDFB46-AAA",
        "foo",
        "2019",
        "",
    ];
    foreach (id; invalid) {
        assert(convUUID(id, false, false).empty);
    }
}
