LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

CRC_SOURCE := crc/crc16.c  crc/crc32.c  crc/crc32c.c  crc/crc32c-intel.c  crc/crc64.c \
		crc/crc7.c  crc/md5.c  crc/sha1.c  crc/sha256.c  crc/sha512.c \
		crc/test.c  crc/xxhash.c crc/murmur3.c crc/fnv.c
SOURCE := gettime.c ioengines.c workqueue.c init.c stat.c log.c time.c filesetup.c filelock.c\
		eta.c verify.c memory.c io_u.c parse.c mutex.c options.c \
		lib/rbtree.c smalloc.c filehash.c profile.c debug.c lib/rand.c \
		lib/num2str.c lib/tp.c lib/prio_tree.c lib/ieee754.c engines/cpu.c \
		engines/mmap.c engines/sync.c engines/null.c engines/net.c engines/libaio.c\
		memalign.c server.c client.c iolog.c backend.c libfio.c flow.c \
		cconv.c json.c lib/zipf.c lib/axmap.c lib/gauss.c\
		lib/lfsr.c gettime-thread.c helpers.c lib/linux-dev-lookup.c lib/flist_sort.c lib/mountcheck.c\
		lib/hweight.c lib/getrusage.c idletime.c td_error.c \
		profiles/tiobench.c profiles/act.c io_u_queue.c fio.c

SOURCE += diskutil.c fifo.c blktrace.c trim.c profiles/tiobench.c

init.o: FIO-VERSION-FILE init.c
	$(QUIET_CC)$(CC) -o init.o $(CFLAGS) $(CPPFLAGS) -c init.c

LOCAL_CFLAGS := -D__ANDROID__ -DFIO_INTERNAL -DBITS_PER_LONG=32 -DFIO_INC_DEBUG -DCONFIG_TLS_THREAD=1 -DCONFIG_LIBAIO=1 -DCONFIG_SOCKLEN_T=1 -DCONFIG_TARGET_OS="\"Android\""  -DCONFIG_GETTIMEOFDAY -DCONFIG_LITTLE_ENDIAN=1 -DFIO_VERSION="\"fio-2.1.6.1\""  -std=gnu99 -Wwrite-strings -Wall -Wdeclaration-after-statement

LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := bionic/libc/bionic bionic
LOCAL_C_INCLUDES += $(LOCAL_PATH)  $(LOCAL_PATH)/lib

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	liblog \
	libc \
	libm \
	libdl \
	libaio \

LOCAL_MODULE := fio

LOCAL_SRC_FILES := $(SOURCE) $(CRC_SOURCE)


include $(BUILD_EXECUTABLE)
