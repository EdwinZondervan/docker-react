#build phase 
FROM node:alpine as builder 	
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build			# build folder -> /app/build, deze willen we kopieren
 
#run phase, begin met een nieuwe image 
FROM nginx	
EXPOSE 80 # elastic bean stalk exposing ports 				
#COPY --from=builder /app/build /usr/share/nginx/html				#copy iets from different phase. 
COPY --from=builder /app/build /usr/share/nginx/html				
#We hoeven nginx niet expliciet te starten omdat dit het default commando is 
