# because of the for loop/pushd/popd
SHELL=/bin/bash

PYTHONS = 3.6 3.7
DEALII_VERSIONS = 9.0.1 8.5.1

.PHONY: pythons $(PYTHONS)

pythons: $(PYTHONS)

$(PYTHONS):
	for DEAL in $(DEALII_VERSIONS) ; do \
		pushd testing && \
		docker build --pull --build-arg PYVER=$@ --build-arg DEALIIVERSION=$${DEAL} -t pymor/dealii:v$${DEAL}_py$@ . && \
		popd ; \
	done

push:
	docker push pymor/dealii

all: dealiis
