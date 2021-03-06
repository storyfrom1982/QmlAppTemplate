/*!
 * COPYRIGHT (C) 2022 Emeric Grange - All Rights Reserved
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * \author    Emeric Grange <emeric.grange@gmail.com>
 * \date      2021
 */

#include "utils_sysinfo.h"

#include <thread>

#include <QProcess>
#include <QDebug>

#if defined(Q_OS_LINUX)
#include <sys/sysinfo.h>
#include <unistd.h>
#endif

#if defined(Q_OS_MACOS)
#include <sys/types.h>
#include <sys/sysctl.h>
#endif

#if defined(Q_OS_WINDOWS)
#include <Windows.h>
#endif

#if defined(Q_OS_ANDROID)
// TODO
#endif

#if defined(Q_OS_IOS)
// TODO
#endif

#if defined(ENABLE_LIBCPUID)
#include <libcpuid/libcpuid.h>
#endif

/* ************************************************************************** */

UtilsSysinfo *UtilsSysinfo::instance = nullptr;

UtilsSysinfo *UtilsSysinfo::getInstance()
{
    if (instance == nullptr)
    {
        instance = new UtilsSysinfo();
    }

    return instance;
}

UtilsSysinfo::UtilsSysinfo()
{
    getCoreInfos();
    getRamInfos();
}

UtilsSysinfo::~UtilsSysinfo()
{
    //
}

/* ************************************************************************** */

void UtilsSysinfo::getCoreInfos()
{
    // Get logical core count (using C++11)
    m_coreCount_logical = std::thread::hardware_concurrency();

    // Default value for physical count == logical count
    m_coreCount_physical = m_coreCount_logical;

#if defined(ENABLE_LIBCPUID)
    // Try to get physical core count (using libcpuid)
    if (cpuid_present())
    {
        struct cpu_raw_data_t raw;
        struct cpu_id_t id;

        if (cpuid_get_raw_data(&raw) == 0 && cpu_identify(&raw, &id) == 0)
        {
            if (id.flags[CPU_FEATURE_HT])
            {
                m_coreCount_physical /= 2;
            }
        }
    }
#else

#if defined(Q_OS_LINUX) || defined(Q_OS_MACOS) || defined(Q_OS_WINDOWS)
    // Desktop OS? Assume HyperThreaded CPU...
    m_coreCount_physical /= 2;
#endif

#endif
}

/* ************************************************************************** */

void UtilsSysinfo::getRamInfos()
{
#if defined(Q_OS_LINUX)

    struct sysinfo info;
    if (sysinfo(&info) == 0)
    {
        m_ramTotal = info.totalram / 1048576; // bytes to MB
    }

#elif defined(Q_OS_MACOS)

    int64_t memsize = 0;
    size_t size = sizeof(memsize);

    if (sysctlbyname("hw.memsize", &memsize, &size, NULL, 0) != -1)
    {
        m_ramTotal = memsize / 1048576; // bytes to MB
    }

#elif defined(Q_OS_WINDOWS)

    GetPhysicallyInstalledSystemMemory(&m_ramTotal);
    m_ramTotal /= 1024; // KB to MB

#endif
}

/* ************************************************************************** */

void UtilsSysinfo::printInfos()
{
    qDebug() << "UtilsSysinfo::getCoreInfos()";
    qDebug() << "> cpu (physical):" << m_coreCount_physical;
    qDebug() << "> cpu (logical) :" << m_coreCount_logical;

    qDebug() << "UtilsSysinfo::getRamInfos()";
    qDebug() << "> RAM size (mb)    :" << m_ramTotal;
}

/* ************************************************************************** */
