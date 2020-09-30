#pragma once

#include<fstream>
#include <iostream>

class Logging
{
public:
	Logging();
	~Logging();

	void InitLogging();

	void WriteLog(const std::string& logstr);
private:
	std::ofstream log_file_;
};

