#include "logging.h"

Logging::Logging()
{
}

Logging::~Logging()
{
	log_file_.close();
}

void Logging::InitLogging()
{
	log_file_.open("this.log", std::ios::out | std::ios::trunc);
}

void Logging::WriteLog(const std::string& logstr)
{
	log_file_ << logstr << std::endl;
}
