import std.getopt : getopt;
import std.stdio : readln, writeln;

import conv : convUUID;

void main(string[] args)
{
    bool dash, upper;
    getopt(args, "dash", &dash, "upper", &upper);

    const src = readln;
    const dst = convUUID(src, dash, upper);

    writeln(dst);
}
