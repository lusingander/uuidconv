import core.stdc.stdlib : exit;
import std.array : empty;
import std.getopt : getopt;
import std.stdio : readln, stderr, writeln;

import uuidconv : convUUID;

void main(string[] args)
{
    bool dash, upper;
    getopt(args, "dash", &dash, "upper", &upper);

    const src = readln;
    const dst = convUUID(src, dash, upper);
    if (dst.empty) {
        stderr.writeln("failed to parse");
        exit(1);
    }

    writeln(dst);
}
