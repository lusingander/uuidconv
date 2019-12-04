import dlangui;
import std.array : empty, replace;
import std.conv : to;
import std.exception : collectException;
import std.uni : toUpper;
import std.uuid : parseUUID;

import uuidconv : convUUID, valid;

mixin APP_ENTRY_POINT;

/// Entry point for dlangui based application
extern (C) int UIAppMain(string[] args)
{
	// Create window
	// arguments: title, parent, flags = WindowFlag.Resizable, width = 0, height = 0
	Window window = Platform.instance.createWindow("UUID Converter", null, 0, 450, 200);

	// Load layout from views/MainWindow.dml and show it
	// Use readText("views/MainWindow.dml") from std.file to allow dynamic layout editting without recompilation
	auto layout = parseML(import("MainWindow.dml"));
	window.mainWidget = layout;

	auto idEdit          = window.mainWidget.childById!EditLine("id_edit");
	auto editUpperDash   = window.mainWidget.childById!EditLine("upper_dash");
	auto editUpperNodash = window.mainWidget.childById!EditLine("upper_nodash");
	auto editLowerDash   = window.mainWidget.childById!EditLine("lower_dash");
	auto editLowerNodash = window.mainWidget.childById!EditLine("lower_nodash");

	idEdit.contentChange = delegate(EditableContent src) {
		const id = idEdit.text;
		if (id.dvalid) {
			editUpperDash.text   = id.dconvUUID(true,  true);
			editUpperNodash.text = id.dconvUUID(false, true);
			editLowerDash.text   = id.dconvUUID(true,  false);
			editLowerNodash.text = id.dconvUUID(false, false);
			idEdit.backgroundColor = "#FEFEFE";
		} else {
			idEdit.backgroundColor = "#AA4444";
		}
	};
	// editUpperDash.click = (Widget w) {
	// 	// TODO: copy text to clipboard
	// 	return true;
	// };

	// Show window
	window.show();

	// Run message loop
	return Platform.instance.enterMessageLoop();
}

bool dvalid(dstring id)
{
	return id.to!string().valid;
}

dstring dconvUUID(dstring id, bool dash, bool upper)
{
	return id.to!string().convUUID(dash, upper).to!dstring();
}