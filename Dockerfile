FROM rstudio/plumber

# install the astas package
RUN R -e 'install.packages(c("astsa"))'

# copy api
RUN mkdir /api
COPY api.R /api
WORKDIR /api

# plumb and run server
EXPOSE 8000
ENTRYPOINT ["R", "-e", \
    "pr <- plumber::plumb('/api/api.R'); pr$run(host='0.0.0.0', port=8000)"]