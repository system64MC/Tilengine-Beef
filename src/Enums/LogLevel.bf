namespace TLN.Enums
{
	public enum LogLevel : uint32 // Debug level
	{
		None, // Don't print anything (default)
		Errors, // Print only runtime errors
		Verbose, // Print everything
	}
}