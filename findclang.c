/*
 * Copyright (c) 2024 TMCIT-LowLayer-Institute.. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    This product includes software developed by the organization.
 * 4. Neither the name of the copyright holder nor the names the copyright holder
 *    nor the names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY COPYRIGHT HOLDER "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDER
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <paths.h>

constexpr auto PATH_SEPARATOR = ':';

int 
main(void) 
{
    char *path = getenv("PATH");
    if (path == NULL) {
        fprintf(stderr, "Error: Could not get the PATH environment variable\n");
        return 1;
    }

    char *path_copy = strdup(path);
    if (path_copy == NULL) {
        fprintf(stderr, "Error: Could not allocate memory for PATH\n");
        return 1;
    }

    char *dir = strtok(path_copy, ":");
    char *found_compiler = nullptr;

    while (dir != NULL) {
        char command[256];
        snprintf(command, sizeof(command), "%s/clang --version", dir);

        FILE *pipe = popen(command, "r");
        if (pipe != NULL) {
            char version_string[100];
            if (fgets(version_string, sizeof(version_string), pipe) != NULL) {
                pclose(pipe);

                /*
                 * Extract version number
                 */
                char *version_ptr = strstr(version_string, "version");
                if (version_ptr != NULL) {
                    double clang_version;
                    if (sscanf(version_ptr + strlen("version"), "%lf", &clang_version) == 1) {
                        /*
                         * Check if version is 18.1.0 or higher
                         */
                        if (clang_version >= 18.1) {
                            found_compiler = strdup(dir);
                            break;  /* Found a suitable compiler, no need to continue searching */
                        }
                    }
                }
            } else {
                pclose(pipe);
            }
        }

        dir = strtok(NULL, ":");
    }

    free(path_copy);

    if (found_compiler != NULL) {
        printf("%s/clang\n", found_compiler);
        free(found_compiler);
        return 0;
    } else {
        fprintf(stderr, "Error: Clang version 18.1.0 or higher not found in PATH\n");
        return 1;
    }
}
