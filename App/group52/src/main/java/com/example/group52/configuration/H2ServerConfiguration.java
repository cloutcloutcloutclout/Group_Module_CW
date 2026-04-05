package com.example.group52.configuration;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.h2.tools.Server;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class H2ServerConfiguration {

    @Bean(initMethod = "start", destroyMethod = "stop")
    @ConditionalOnProperty(prefix = "spring.h2.tcp", name = "enabled", havingValue = "true", matchIfMissing = true)
    public Server h2TcpServer() throws SQLException {
        List<String> args = new ArrayList<>(List.of("-tcp", "-tcpPort", "8082"));

        if (Boolean.getBoolean("h2.tcp.allow-others") || "true".equalsIgnoreCase(System.getenv("H2_TCP_ALLOW_OTHERS"))) {
            args.add("-tcpAllowOthers");
        }

        return Server.createTcpServer(args.toArray(new String[0]));
    }
}
